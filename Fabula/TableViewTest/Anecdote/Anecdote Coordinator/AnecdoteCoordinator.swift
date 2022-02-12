//
//  AnecdoteCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 17/12/2021.
//

import Foundation
import UIKit

class AnecdoteCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var parentCoordinator: HomeCoordinator?
    
    var navigationController: UINavigationController
    
//    var anecdoteViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        self.navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(connexionTapped))
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        self.navigationController.navigationBar.barTintColor = .deepBlue
        self.navigationController.navigationBar.tintColor = .white
       
    }
    
    func start() {
        let vc = AnecdoteViewController.instantiate()
        vc.coordinator = self
        vc.anecdoteViewModel = AnecdoteViewModel(delegate: self)
//        anecdoteViewController = vc
        vc.tabBarItem = UITabBarItem(title: "Anecdote", image: UIImage(named: "Book"), tag: 1)
//        UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
//        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        let vc = DetailAnecdoteTableViewController.instantiate()
        vc.isFavoriteNavigation = isFavoriteNavigation
        vc.detailAnecdoteViewModel = DetailAnecdoteViewModel(showFavoriteDelegate: self)
        
        vc.coordinator = self
        vc.commentIsTapped = commentIsTapped
        vc.anecdote = anecdote
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavorite() {
        let vc = FavoriteViewController.instantiate()
        vc.coordinator = self
        vc.favoriteViewModel = FavoriteViewModel(anecdoteDetailDelegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSearch() {
        let vc = SearchViewController.instantiate()
        vc.coordinator = self
        
        vc.searchViewModel = SearchViewModel(delegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func didFinishAnecdote() {
        parentCoordinator?.childDidFinish(self)
    }
    
//    @objc func connexionTapped() {
//        guard let anecdoteViewController = anecdoteViewController else {
//            return
//        }
//
//        UserConnexion().showUserConnexion(on: anecdoteViewController)
//    }
    
}

extension AnecdoteCoordinator: AnecdoteDetailDelegate {
    func getDetail(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        showDetail(anecdote: anecdote, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
    }
}

extension AnecdoteCoordinator: ShowFavoriteDelegate {
    func showFavoriteDelegate() {
        showFavorite()
    }
}


