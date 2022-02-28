//
//  MapViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/01/2022.
//

import UIKit
import MapKit


final class MapViewController: UIViewController, StoryBoarded, CLLocationManagerDelegate {
    
    var coordinator: MapCoordinator?
    
    let locationManager = CLLocationManager()
    
    var parisAnnotations: [ParisAnnotation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Autour de vous"
   // set up data and delegate
        loadInitialData()
        mapView.addAnnotations(parisAnnotations)
        mapView.delegate = self
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
    }
    // get the user authorization, set delegate and accuracy, get user location
    func initializeLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    // get user authorization status
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
                showAlert()
            case.notDetermined:
                showAlert()
            case.restricted:
                showAlert()
            @unknown default:
                fatalError()
        }
    }
    // get the first location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    // set the map on the user location
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    // if authorization is denied show alert
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
    // create annotation
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
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
        }
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return view
    }
    // set up accessoryControl
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let parisAnnotation = view.annotation as? ParisAnnotation else {
            return
        }
        
        coordinator?.showDetailMap(annotation: parisAnnotation)
    }
}
