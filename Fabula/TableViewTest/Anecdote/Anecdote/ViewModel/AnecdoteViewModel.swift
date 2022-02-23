//
//  AnecdoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 15/12/2021.
//

import Foundation
import FirebaseFirestore

class AnecdoteViewModel {
    
    var anecdoteService = AnecdoteService()
    var delegate: AnecdoteDetailDelegate!
    var resultMapped = [Anecdote]()
    
    init(anecdoteService: AnecdoteService = AnecdoteService()) {
        self.anecdoteService = anecdoteService
    }
    
    // MARK: - OutPut
    
    var anecdotesToDisplay: ((Result<[Anecdote], NetworkError>) -> Void)?
    var anecdotes = [Anecdote]()
    var numberOfFavorites: ((Int) -> Void)?
    
    init(delegate: AnecdoteDetailDelegate) {
        self.delegate = delegate
    }

    func getNewAnecdotes() {
        anecdoteService.getNewAnecdotes(dataRequest: DataRequest.anecdotes.rawValue) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.anecdotesToDisplay?(.failure(error))
            case.success(let fetchedAnecdotes):
                self?.anecdotes.append(contentsOf: fetchedAnecdotes)
                self?.anecdotesToDisplay?(.success(self?.anecdotes ?? [Anecdote]()))
            }
        }
    }
    
    func getAnecdotes() {
        
        anecdoteService.getAnecdotes(dataRequest: DataRequest.anecdotes.rawValue) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.anecdotesToDisplay?(.failure(error))
            case.success(let fetchedAnecdotes):
                self?.anecdotes.append(contentsOf: fetchedAnecdotes)
                self?.anecdotesToDisplay?(.success(self?.anecdotes ?? [Anecdote]()))
            }
        }
    }
    
    func getFavNumber() {
        let numberOfFavorite = UserDefaultsManager().retrieveFavCount()
        numberOfFavorites?(numberOfFavorite)
    }
    
    func selectedRow(row: Int, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        let selectedAnecdote = resultMapped[row]
        delegate.getDetail(anecdote: selectedAnecdote, commentIsTapped: commentIsTapped, isFavoriteNavigation: isFavoriteNavigation)
    }
}

