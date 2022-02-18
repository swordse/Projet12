//
//  DetailAnecdoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/01/2022.
//

import Foundation
import UIKit
import Firebase


class DetailAnecdoteViewModel {
    
    var anecdoteService = AnecdoteService()
//    var coreDataService = CoreDataService()
    var coreDataSession: BackupSession
    var resultComments = [Comment]()
    var favorites = [Anecdote]()
    var anecdoteIsFavorite: Bool?

//    var coreDataStack: CoreDataStack!
//    var coreDataManager: CoreDataManager!
    
    var showFavoriteDelegate: ShowFavoriteDelegate
    
    init(coreDataSession: BackupSession = CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: AnecdoteService = AnecdoteService(), showFavoriteDelegate: ShowFavoriteDelegate) {
           self.coreDataSession = coreDataSession
           self.anecdoteService = anecdoteService
           self.showFavoriteDelegate = showFavoriteDelegate
       }
    
    // MARK: - OutPut
    
    var comments: ((Result<[Comment], NetworkError>) -> Void)?
    var isFavorite: ((Bool) -> Void)?
    var favCount: ((Int) -> Void)?

    
    func save(comment: String, anecdoteId: String) {
        guard let user = UserDefaultsManager().retrieveUser() else { return }

        let commentToSave: [String: Any] = [
            "commentText": comment,
            "userName": user["userName"] as Any,
            "userId": user["userId"] as Any,
            "anecdoteId": anecdoteId,
            "date": Timestamp(date: Date())]
        
        anecdoteService.save(commentToSave: commentToSave, anecdoteId: anecdoteId) { bool in
            if bool {
                self.getComments(id: anecdoteId)
            }
        }
        
    }
    
    func getComments(id: String) {
        anecdoteService.getComments(anecdoteId: id) { result in
            switch result {
            case.failure(let error):
                self.comments?(.failure(error))
            case.success(let result):
                self.comments?(.success(result))
            }
        }
    }
    
    func getFavorite() {
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let coreDataStack = appDelegate.coreDataStack
//        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        // A REMETTRE AU BESOIN
//        guard let favorites = coreDataSession.favorites else { return }
        
        let anecdotes: [Anecdote] = coreDataSession.favorites.map { favorite in
            let source = favorite.source
            let id = favorite.id ?? ""
            let categorie = Category(rawValue: favorite.categorie ?? "Picture")
            let title = favorite.title ?? ""
            let text = favorite.text ?? ""
            let date = favorite.date ?? ""
            
            return Anecdote(id: id, categorie: categorie!, title: title, text: text, source: source, date: date, isFavorite: true)
        }
        self.favorites = anecdotes
    }
    
    
    func isFavorite(anecdote: Anecdote) {
        if favorites.contains(where: { favorite in
            favorite.id == anecdote.id
        }) {
            isFavorite?(true)
            self.anecdoteIsFavorite = true
        } else {
            isFavorite?(false)
            self.anecdoteIsFavorite = false
        }
    }
    
    func saveFavorite( anecdote: Anecdote) {
        
        if coreDataSession.favorites.contains(where: { favorite in
            favorite.id == anecdote.id
        }) { return }
    
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        coreDataStack = appDelegate.coreDataStack
//            coreDataManager = CoreDataManager(coreDataStack: coreDataStack!)
        
        coreDataSession.createFavorite(anecdote: anecdote)
       
        // update the favorite count (retrieve the actual count and add 1)
        let favoriteCount = UserDefaultsManager().retrieveFavCount()
        print("FV COUNT: \(favoriteCount)")
        UserDefaultsManager().saveFavorite(number: favoriteCount + 1)
        favCount?(favoriteCount + 1)
    }
    
    
    func deleteFavorite(anecdote: Anecdote) {
    
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let coreDataStack = appDelegate.coreDataStack
//        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        coreDataSession.deleteFavorite(anecdote: anecdote)
        
        // update the favorite count (retrieve the actual count and substract 1)
        let favoriteCount = UserDefaultsManager().retrieveFavCount()
        print("FV COUNT: \(favoriteCount)")
        if favoriteCount > 0 {
        UserDefaultsManager().saveFavorite(number: favoriteCount - 1)
            favCount?(favoriteCount - 1)
        }
        
    }
    
    func showFavorite() {
        showFavoriteDelegate.showFavoriteDelegate()
    }
    
   
    
}

