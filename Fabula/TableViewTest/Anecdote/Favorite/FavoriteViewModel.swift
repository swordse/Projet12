//
//  FavoriteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import Foundation
import UIKit

class FavoriteViewModel {
    
    var coreDataSession: BackupSession
    var anecdoteDetailDelegate: AnecdoteDetailDelegate!
    var favorites = [Anecdote]()
    let favoriteNavButton = BadgedButtonItem.shared
    
    init(coreDataSession: BackupSession = CoreDataSession(coreDataStack: CoreDataStack()), anecdoteDetailDelegate: AnecdoteDetailDelegate) {
        self.coreDataSession = coreDataSession
        self.anecdoteDetailDelegate = anecdoteDetailDelegate
    }
    
    //    MARK: - Output
    var favoriteAnecdote: (([Anecdote])-> Void)?
    
    func getFavorite() {
        
        let favorites = coreDataSession.favorites
        
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
        favoriteAnecdote?(anecdotes)
    }
    
    func selectedRow(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        
        let selectedFavorite = anecdote
        anecdoteDetailDelegate.getDetail(anecdote: selectedFavorite, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
    }
}
