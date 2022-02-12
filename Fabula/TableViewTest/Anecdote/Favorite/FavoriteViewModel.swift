//
//  FavoriteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import Foundation
import UIKit

class FavoriteViewModel {
    
    var coreDataManager: CoreDataManager?
    
    var anecdoteDetailDelegate: AnecdoteDetailDelegate!
    
    var favorites = [Anecdote]()
    
    let favoriteNavButton = BadgedButtonItem.shared

    
//    MARK: - Output
    
    var favoriteAnecdote: (([Anecdote])-> Void)?
    
    init(anecdoteDetailDelegate: AnecdoteDetailDelegate) {
        self.anecdoteDetailDelegate = anecdoteDetailDelegate
    }
    
    func getFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        guard let favorites = coreDataManager?.favorites else {
            favoriteAnecdote?([Anecdote]())
            return
        }
    
        favoriteNavButton.setBadge(with: favorites.count)
        
        let anecdotes: [Anecdote] = favorites.map { favorite in
            
            let source = favorite.source
            let id = favorite.id ?? ""
            let categorie = Category(rawValue: favorite.categorie ?? "Picture")
            let title = favorite.title ?? ""
            let text = favorite.text ?? ""
            let date = favorite.date ?? ""
            
            
            return Anecdote(id: id, categorie: categorie!, title: title, text: text, source: source, date: date, isFavorite: true)
        }
        self.favorites = anecdotes
        print("favorite from getFavorite favorite viewmodel \(favorites)")
        favoriteAnecdote?(anecdotes)
    }
    
    func selectedRow(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
       
        let selectedFavorite = anecdote
        anecdoteDetailDelegate.getDetail(anecdote: selectedFavorite, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
      
    }
    

}
