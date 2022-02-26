//
//  AnecdoteCoordinator.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 17/12/2021.
//

import Foundation
import UIKit

// coordinator to show AnecdoteVC, DetailVC, SearchVC, FavoriteVC
final class AnecdoteCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: HomeCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.barTintColor = .deepBlue
        self.navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let vc = AnecdoteViewController.instantiate()
        vc.coordinator = self
        vc.anecdoteViewModel = AnecdoteViewModel(delegate: self)
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


