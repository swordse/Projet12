//
//  ParisAnnotation.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/01/2022.
//

import Foundation
import MapKit
import Contacts

class ParisAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var locationName: String?
    var coordinate: CLLocationCoordinate2D
    
    var text: String?
    
    
    var subtitle: String? {
        return locationName
    }
    
    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D, text: String?) {
        
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.text = text
    }
    
    init?(feature: MKGeoJSONFeature) {
        
        guard let point = feature.geometry.first as? MKPointAnnotation,
              let propertiesData = feature.properties,
              let json = try? JSONSerialization.jsonObject(with: propertiesData),
              let properties = json as? [String: Any] else {
                  return nil
              }
        title = properties["nom_poi"] as? String
        locationName = properties["categorie"] as? String
        coordinate = point.coordinate
        
        text = properties["texte_description"] as? String
        
        super.init()
        
    }
    
    var mapItem: MKMapItem? {
        guard let location = locationName else {
            return nil
        }
        let adressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: adressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    
    
    
}
