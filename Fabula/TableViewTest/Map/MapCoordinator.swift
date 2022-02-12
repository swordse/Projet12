//
//  MapCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/01/2022.
//

import Foundation
import UIKit

class MapCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: HomeCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.barTintColor = UIColor.deepBlue
        self.navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: "Carte", image: UIImage(named: "Book"), tag: 3)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailMap(annotation: ParisAnnotation) {
        let vc = DetailMapViewController.instantiate()
        vc.coordinator = self
        vc.annotation = annotation
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
}
