//
//  AnecdoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 15/12/2021.
//

import Foundation
import UIKit
import FirebaseFirestore

class AnecdoteViewModel {
    
    let network = NetworkAnecdotes()
    
    var delegate: AnecdoteDetailDelegate!
    
    var resultMapped = [Anecdote]()
    
    var lastSnapshot: QueryDocumentSnapshot?
    
    // MARK: - OutPut
    
    var anecdotesToDisplay: ((Result<[Anecdote], NetworkError>) -> Void)?
    
    var numberOfFavorites: ((Int) -> Void)?
    
    init(delegate: AnecdoteDetailDelegate) {
        self.delegate = delegate
    }
    // if there are more anecdotes, lastSnapshot isn't nil
    func getNewAnecdotes() {
        guard let lastSnapshot = lastSnapshot else {
            return
        }

        network.getAnecdotes(lastSnapshot: lastSnapshot) { result, lastSnapshot in
            switch result {
            case.success(let result):
                self.resultToAnecdote(result: result)
            case.failure(let error):
                self.anecdotesToDisplay?(.failure(error))
            }
            self.lastSnapshot = lastSnapshot
        }
    }
    
    func getAnecdotes() {
        
        network.getAnecdotes(lastSnapshot: nil) { result, lastSnapshot in
            switch result {
            case.success(let result):
                self.resultToAnecdote(result: result)
            case.failure(let error):
                self.anecdotesToDisplay?(.failure(error))
                print("erreur lors de l'appel des anecdotes \(result)")
            }
            self.lastSnapshot = lastSnapshot
        }
    }
    
    func resultToAnecdote(result: [[String : Any]]) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        let resultAnecdotes: [Anecdote] = result.map { item in
            
            let categorie = getCategory(item: item)

            return Anecdote(id: item["id"] as! String,
                            categorie:  categorie,
                            title: item["title"] as! String,
                            text: item["text"] as! String,
                            source: (item["source"] as? String) ?? nil,
                            date: formatter.string(from:item["Date"] as! Date),
                            isFavorite: false)
        }
        resultMapped.append(contentsOf: resultAnecdotes)
        anecdotesToDisplay?(.success(resultMapped))
    }
    
    func getCategory(item: [String: Any]) -> Category {
        return (Category(rawValue: item["category"] as! String) ?? Category(rawValue: "Picture"))!
    }
    
    func getFavNumber() {
        let numberOfFavorite = UserDefaultManager.retrieveFavCount()
        print("NUMBER OF FAV IN GETFAVNUMBER ANECDOTEVIEWMODEL: \(numberOfFavorite)")
        numberOfFavorites?(numberOfFavorite)
    }
    
    func selectedRow(row: Int, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        let selectedAnecdote = resultMapped[row]
        delegate.getDetail(anecdote: selectedAnecdote, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
    }

}

