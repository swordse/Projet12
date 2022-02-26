//
//  SearchViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 18/01/2022.
//

import Foundation
import FirebaseFirestore

final class SearchViewModel {
    
    var searchService = AnecdoteService()
    var anecdotes = [Anecdote]()
    var searchResult = [Anecdote]()
    
    var delegate: AnecdoteDetailDelegate!
    
    init(searchService: AnecdoteService = AnecdoteService(), delegate: AnecdoteDetailDelegate) {
        self.searchService = searchService
        self.delegate = delegate
    }
    
    // -MARK: Output
    var allAnecdotes: ((Result<[Anecdote], NetworkError>) -> Void)?
    
    var resultAnecdotes: (([Anecdote]) -> Void)?
    
    // -MARK: Methods
    func getAllAnecdotes() {
        searchService.getAllAnecdotes(dataRequest: DataRequest.anecdotes.rawValue) { result in
            switch result {
            case.success(let anecdotes):
                self.anecdotes = anecdotes
                self.allAnecdotes?(.success(anecdotes))
            case.failure(let error):
                self.allAnecdotes?(.failure(error))
            }
        }
    }
    
    func searchInAnecdote(words: [String]) {
        var result = [Anecdote]()
        
        for anecdote in anecdotes {
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
    }
    
}
