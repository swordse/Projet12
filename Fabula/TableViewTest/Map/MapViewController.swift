//
//  MapViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/01/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, StoryBoarded, CLLocationManagerDelegate {
    
    let userAccount = UserAccount()
    
    var coordinator: MapCoordinator?
    
    let locationManager = CLLocationManager()
    
    var parisAnnotations: [ParisAnnotation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Autour de vous"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        //        let parisAnnotation = ParisAnnotation(title: "title", locationName: "locationName", coordinate: CLLocationCoordinate2D(latitude: 48.8284628153, longitude: 2.32251017675))
        
        loadInitialData()
        mapView.addAnnotations(parisAnnotations)
        
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initializeLocation()
    }
    // get annotation from json
    func loadInitialData() {
        guard let fileName = Bundle.main.url(forResource: "GeoParis", withExtension: "geojson"), let parisAnnotationData = try? Data(contentsOf: fileName) else {
            return
        }
        do {
            let features = try MKGeoJSONDecoder().decode(parisAnnotationData).compactMap({$0 as? MKGeoJSONFeature })
            let validAnnotations = features.compactMap(ParisAnnotation.init)
            parisAnnotations.append(contentsOf: validAnnotations)
        } catch {
            print("error when creating parisannotation \(error)")
        }
        print("parisannotation count = \(parisAnnotations.count)")
    }
    
    
    func initializeLocation() {
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case.authorized:
            mapView.showsUserLocation = true
        case.authorizedWhenInUse:
            mapView.showsUserLocation = true
        case.authorizedAlways:
            mapView.showsUserLocation = true
        case.denied:
            print("refus")
            showAlert()
        case.notDetermined:
            print("refus")
            showAlert()
        case.restricted:
            print("refus")
            showAlert()
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Pour utiliser cette fonctionnalité, vous devez autoriser votre localisation dans les paramètres.", message: "Merci d'accepter la localisation.", preferredStyle: .alert)
        let rejectAction = UIAlertAction(title: "Refuser", style: .cancel, handler: nil)
        let changeSettingsAction = UIAlertAction(title: "Modifier", style: .default, handler: openSettings(alert:))
        alert.addAction(rejectAction)
        alert.addAction(changeSettingsAction)
                                                 present(alert, animated: true, completion: nil)
                                                 }
                                                 
                                                 func openSettings(alert: UIAlertAction) {
            if let url = URL.init(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
                                                 
                                                 }
                                                 
                                                 extension MapViewController: MKMapViewDelegate {
            
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                guard let annotation = annotation as? ParisAnnotation else {
                    return nil
                }
                let identifier = "parisAnnotation"
                var view: MKMarkerAnnotationView
                
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                } else {
                    print("else annotation is created")
                    view = MKMarkerAnnotationView(
                        annotation: annotation,
                        reuseIdentifier: identifier)
                    //            view.canShowCallout = true
                    //            view.calloutOffset = CGPoint(x: -5, y: 5)
                    //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                }
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return view
            }
            
            
            func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                
                guard let parisAnnotation = view.annotation as? ParisAnnotation else {
                    return
                }
                
                coordinator?.showDetailMap(annotation: parisAnnotation)
                //        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
                //
                //        parisAnnotation.mapItem?.openInMaps(launchOptions: launchOptions)
            }
        }
