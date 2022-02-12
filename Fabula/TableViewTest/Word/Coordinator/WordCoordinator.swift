//
//  WordCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation
import UIKit

class WordCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: HomeCoordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.barTintColor = .deepBlue
        self.navigationController.navigationBar.tintColor = .white
        
    }
    
    func start() {
        
        let vc = WordViewController.instantiate()
        vc.coordinator = self
        vc.wordViewModel = WordViewModel()
        vc.tabBarItem = UITabBarItem(title: "Mot", image: UIImage(named: "Word"), tag: 5)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
