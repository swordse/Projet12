//
//  DetailAnecdoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/01/2022.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class DetailAnecdoteViewModel {
    
    let network = NetworkAnecdotes()
    var resultMapped = [Comment]()
    var favorites = [Anecdote]()

    var coreDataManager: CoreDataManager?
    
    var showFavoriteDelegate: ShowFavoriteDelegate
    
    // MARK: - OutPut
    
    var comments: (([Comment]) -> Void)?
    var isFavorite: ((Bool) -> Void)?
    var favCount: ((Int) -> Void)?
    
    init(showFavoriteDelegate: ShowFavoriteDelegate) {
        self.showFavoriteDelegate = showFavoriteDelegate
    }
    
    func save(comment: String, anecdoteId: String) {
        guard let user = UserDefaultManager.retrieveUser() else {
            return
        }

        let commentToSave: [String: Any] = [
            "commentText": comment,
            "userName": user["userName"] as Any,
            "userId": user["userId"] as Any,
            "anecdoteId": anecdoteId,
            "date": Timestamp(date: Date())]
        
        let database = Firestore.firestore()
        
        database.collection("comments").document().setData(commentToSave) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            // when comment is save, retrieve comments to update tableview
            self.getComments(id: anecdoteId)
        }
        
    }
    
    func getComments(id: String) {
        network.readComments(anecdoteId: id) { result in
            switch result {
            case.failure:
                print("error")
            case.success(let result):
                self.resultToComments(result: result)
            }
        }
    }
    
    func resultToComments(result: [[String: Any]]) {
       
        resultMapped = result.map({ item in
            return Comment(anecdoteId: item["anecdoteId"] as! String, commentText: item["commentText"] as! String, date: ((item["date"] as? Date)) ?? Date(), userName: item["userName"] as! String, userId: item["userId"] as! String)
        })
       
        let orderedResult = resultMapped.sorted { $0.date < $1.date }
        
        comments?(orderedResult)
    }
    
    func getFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        guard let favorites = coreDataManager?.favorites else {
            return
        }
        
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
    }
    
    func isFavorite(anecdote: Anecdote) {
        if favorites.contains(where: { favorite in
            favorite.id == anecdote.id
        }) {
            isFavorite?(true)
        } else {
            isFavorite?(false)
        }
    }
    
    
    func saveFavorite(anecdote: Anecdote) {
        
        if favorites.contains(where: { favorite in
            favorite.id == anecdote.id
        }) {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        coreDataManager?.createFavorite(anecdote: anecdote)
       
        // update the favorite count (retrieve the actual count and add 1)
        let favoriteCount = UserDefaultManager.retrieveFavCount()
        print("FV COUNT: \(favoriteCount)")
        UserDefaultManager.saveFavorite(number: favoriteCount + 1)
        
        favCount?(favoriteCount + 1)
    }
    
    func deleteFavorite(anecdote: Anecdote) {
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        coreDataManager?.deleteFavorite(anecdote: anecdote)
        
        // update the favorite count (retrieve the actual count and substract 1)
        let favoriteCount = UserDefaultManager.retrieveFavCount()
        print("FV COUNT: \(favoriteCount)")
        if favoriteCount > 0 {
        UserDefaultManager.saveFavorite(number: favoriteCount - 1)
            favCount?(favoriteCount - 1)
        }
        
    }
    
    func showFavorite() {
        showFavoriteDelegate.showFavoriteDelegate()
    }
    
   
    
}

