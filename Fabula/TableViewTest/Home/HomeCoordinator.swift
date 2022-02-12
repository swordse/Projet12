//
//  HomeCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 23/12/2021.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController:  UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.barTintColor = UIColor.deepBlue
        self.navigationController.navigationBar.tintColor = .label

    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)

        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showAnecdotes() {
        let child = AnecdoteCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func showQuizz() {
        let child = QuizzCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func showWord() {
        let child = WordCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func showQuote() {
        let child = QuoteCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func showMap() {
        let child = MapCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("navigationcontroller didshow est utilisé")
        print("total child au début de didshow \(childCoordinators.count)")
        // Read the view controller we’re moving from.
            guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
                return
            }

            // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
            if navigationController.viewControllers.contains(fromViewController) {
                return
            }

            // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
            if let anecdoteViewController = fromViewController as? AnecdoteViewController {
                // We're popping a buy view controller; end its coordinator
                childDidFinish(anecdoteViewController.coordinator)
            }
        print("total child à la FIN de didshow \(childCoordinators.count)")
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }

    
}
