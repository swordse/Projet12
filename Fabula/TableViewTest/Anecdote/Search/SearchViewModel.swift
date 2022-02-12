//
//  SearchViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 18/01/2022.
//

import Foundation
import FirebaseFirestore

class SearchViewModel {
    
    var network = NetworkAnecdotes()
    
    var resultMapped = [Anecdote]()
    var searchResult = [Anecdote]()
    var lastSnapshot: QueryDocumentSnapshot?
    
    var delegate: AnecdoteDetailDelegate!
    
    // -MARK: Output
    var fetchAnecdotes: ((Result<[Anecdote], Error>) -> Void)?
    
    var resultAnecdotes: (([Anecdote]) -> Void)?
    
    init(delegate: AnecdoteDetailDelegate) {
        self.delegate = delegate
    }
    
    func getAnecdotes() {
        
        network.getAnecdotes(lastSnapshot: lastSnapshot) { result, lastSnapshot in
            switch result {
            case.success(let result):
                self.resultToAnecdote(result: result)
            case.failure:
                self.fetchAnecdotes?(.failure(result as! Error))
            }
            self.lastSnapshot = lastSnapshot
        }
    }
    
    // firebase don't support text search
//    func searchNetwork(searchItems: [String]) {
//        print("SEARCHNETWORK STARTS")
//        network.searchAnecdote(items: searchItems) { result in
//            print("RESULT OF SEARCH: \(result)")
//            switch result {
//            case.success(let result):
//                self.resultToAnecdote(result: result)
//            case .failure(let error):
//                self.fetchAnecdotes?(.failure(error))
//            }
//        }
//    }
    
    func resultToAnecdote(result: [[String: Any]]) {
        resultMapped = result.map { item in
            
            let categorie = getCategory(item: item)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"

            return Anecdote(id: item["id"] as! String,
                            categorie:  categorie,
                            title: item["title"] as! String,
                            text: item["text"] as! String,
                            source: (item["source"] as? String) ?? nil,
                            date: formatter.string(from:item["Date"] as! Date),
                            isFavorite: false)
        }
        fetchAnecdotes?(.success(resultMapped))
    }
    
    func getCategory(item: [String: Any]) -> Category {
        return (Category(rawValue: item["category"] as! String) ?? Category(rawValue: "Picture"))!
    }
    
    func searchInAnecdote(words: [String]) {
        
        var result = [Anecdote]()
        
        for anecdote in resultMapped {
            for word in words {
                if anecdote.text.lowercased().contains(word.lowercased()) {
                    if !result.contains(where: { result in
                        result.id == anecdote.id
                    }) {
                    result.append(anecdote)
                    }
                }
            }
        
        }
        searchResult = result
        resultAnecdotes?(result)
    }
    
    
    func selectedRow(int: Int) {
        let selectedAnecdote = searchResult[int]
        delegate.getDetail(anecdote: selectedAnecdote, commentIsTapped: false, isFavoriteNavigation: false)
        
//        self.anecdoteTextToShare?(selectedAnecdote.text)
    }
    
}
