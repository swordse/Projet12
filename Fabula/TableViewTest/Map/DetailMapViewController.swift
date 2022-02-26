//
//  DetailMapViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 30/01/2022.
//

import UIKit
import MapKit

final class DetailMapViewController: UIViewController, StoryBoarded {

    var coordinator: MapCoordinator?
    
    var annotation: ParisAnnotation?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var annotationTextview: UITextView!
    
    @IBOutlet weak var itineraryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itineraryButton.layer.cornerRadius = 15
        guard let annotation = annotation else {
            return
        }
        setView(annotation: annotation)
    }
    
    func setView(annotation: ParisAnnotation) {
        titleLabel?.text = annotation.title
        
        let cleanText = annotation.text?.replacingOccurrences(of: "?", with: "")
        
        annotationTextview?.text = cleanText
    }

    @IBAction func itineraryButtonTapped(_ sender: Any) {
        guard let annotation = annotation else {
            return
        }

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        
        annotation.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
