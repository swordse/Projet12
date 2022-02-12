//
//  QuoteViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import Foundation

class QuoteViewModel {
    
    var quoteService = QuoteService()
    var quotes = [Quote]()
    
    init(quoteService: QuoteService = QuoteService(), quotes: [Quote] = [Quote]()) {
        self.quoteService = quoteService
        self.quotes = quotes
    }
    
    // Output
    
    var quotesToDisplay: ((Result<[Quote], NetworkError>) -> Void)?
    
    func getQuotes() {
        quoteService.getQuote { result in
            switch result {
            case.success(let quotes):
                self.quotes.append(contentsOf: quotes)
                self.quotesToDisplay?(.success(quotes))
            case.failure(let error):
                self.quotesToDisplay?(.failure(error))
            }
        }
    }
    
    func getNewQuotes() {
        quoteService.getNewQuote { result in
            switch result {
            case.success(let quotes):
                self.quotes.append(contentsOf: quotes)
                self.quotesToDisplay?(.success(self.quotes))
            case.failure(let error):
                self.quotesToDisplay?(.failure(error))
            }
        }
    }
    
}
