//
//  Alert.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 07/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(networkError: NetworkError) {
        let alert = UIAlertController(title: "Erreur", message: networkError.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func emptyFavoriteAlert() {
        let alert = UIAlertController(title: "Vous n'avez pas de favoris", message: """
Pour en ajouter, cliquez sur le coeur
dans le détail d'une anecdote.
""", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
