//
//  QuizzCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/12/2021.
//

import Foundation
import UIKit

final class QuizzCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var parentCoordinator: HomeCoordinator?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController.navigationBar.barTintColor = UIColor.deepBlue
        self.navigationController.navigationBar.tintColor = .white
    }
    // show homequizzviewcontroller
    func start() {
        let vc = HomeQuizzViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = HomeQuizzViewModel(delegate: self)
        vc.tabBarItem = UITabBarItem(title: "Quizz", image: UIImage(named: "Game"), tag: 2)
        
        navigationController.pushViewController(vc, animated: true)
    }
    // show quizz
    func showQuizz(quizzs: [Quizz]) {
        let vc = TestQuizzViewController.instantiate()
        vc.coordinator = self
        vc.viewmodel = TestQuizzViewModel(quizzs: quizzs)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}

extension QuizzCoordinator: QuizzGetTest {
    func getTest(quizzs: [Quizz]) {
        showQuizz(quizzs: quizzs)
    }
}
