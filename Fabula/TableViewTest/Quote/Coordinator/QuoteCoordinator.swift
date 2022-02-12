//
//  QuoteCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import Foundation
import UIKit

class QuoteCoordinator: Coordinator {
    
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
        let vc = QuoteViewController.instantiate()
        vc.quoteViewModel = QuoteViewModel()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: "Citation", image: UIImage(named:"Quote"), tag: 4)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
