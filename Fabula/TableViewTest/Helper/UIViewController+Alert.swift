//
//  Alert.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 07/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert() {
        let alert = UIAlertController(title: "Erreur", message: "Une erreur s'est produite. Vérifiez votre connexion internet.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
