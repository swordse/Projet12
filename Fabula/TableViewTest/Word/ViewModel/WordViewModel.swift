//
//  WordViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation

final class WordViewModel {
    
    var wordService = WordService()
    var words = [Word]()
    
    init(wordService: WordService = WordService(), words: [Word] = [Word]()) {
        self.wordService = wordService
        self.words = words
    }
    
    //    MARK: - Output
    var wordsToDisplay: ((Result<[Word], NetworkError>) -> Void)?
    //    MARK: - Methods
    // func to update wordsToDisplay
    func getWords() {
        wordService.getWords(dataRequest: DataRequest.words.rawValue) { result in
            switch result {
            case.success(let resultWords):
                self.words.append(contentsOf: resultWords)
                self.wordsToDisplay?(.success(self.words))
            case.failure(let error):
                self.wordsToDisplay?(.failure(error))
            }
        }
    }
    
    func getNewWords() {
        wordService.getNewWords(dataRequest: DataRequest.words.rawValue) { result in
            switch result {
            case.success(let resultWords):
                self.words.append(contentsOf: resultWords)
                self.wordsToDisplay?(.success(self.words))
            case.failure(let error):
                self.wordsToDisplay?(.failure(error))
            }
        }
    }
    
}
