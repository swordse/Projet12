//
//  DetailAnecdoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/01/2022.
//

import Foundation
import Firebase


class DetailAnecdoteViewModel {
    
    var anecdoteService = AnecdoteService()
    var coreDataSession: BackupSession
    var resultComments = [Comment]()
    var favorites = [Anecdote]()
    var anecdoteIsFavorite: Bool?
    
    var showFavoriteDelegate: ShowFavoriteDelegate
    
    init(coreDataSession: BackupSession = CoreDataService(coreDataStack: CoreDataStack()), anecdoteService: AnecdoteService = AnecdoteService(), showFavoriteDelegate: ShowFavoriteDelegate) {
           self.coreDataSession = coreDataSession
           self.anecdoteService = anecdoteService
           self.showFavoriteDelegate = showFavoriteDelegate
       }
    
    // MARK: - OutPut
    
    var comments: ((Result<[Comment], NetworkError>) -> Void)?
    var isFavorite: ((Bool) -> Void)?
    var favCount: ((Int) -> Void)?
    
// save comment add by user in firestore
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
   // retrieve comments save in firestore
    func getComments(id: String) {
        anecdoteService.getComments(anecdoteId: id) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.comments?(.failure(error))
            case.success(let result):
                self?.comments?(.success(result))
            }
        }
    }
    // retrieve favorite anecdotes from coredata
    func getFavorite() {
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
    
    // check if anecdote is already a favorite
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
    // save favorite in coreData
    func saveFavorite( anecdote: Anecdote) {
        if coreDataSession.favorites.contains(where: { favorite in
            favorite.id == anecdote.id
        }) { return }

        coreDataSession.createFavorite(anecdote: anecdote)
       
        // update the favorite count (retrieve the actual count and add 1)
        let favoriteCount = UserDefaultsManager().retrieveFavCount()
        UserDefaultsManager().saveFavorite(number: favoriteCount + 1)
        favCount?(favoriteCount + 1)
    }
    
    
    func deleteFavorite(anecdote: Anecdote) {
        
        coreDataSession.deleteFavorite(anecdote: anecdote)
        // update the favorite count (retrieve the actual count and substract 1)
        let favoriteCount = UserDefaultsManager().retrieveFavCount()
        if favoriteCount > 0 {
        UserDefaultsManager().saveFavorite(number: favoriteCount - 1)
            favCount?(favoriteCount - 1)
        }
    }
    
    func showFavorite() {
        showFavoriteDelegate.showFavoriteDelegate()
    }
    
}

