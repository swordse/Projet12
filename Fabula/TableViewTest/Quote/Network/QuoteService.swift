//
//  QuoteNetWork.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import Foundation


final class QuoteService {
    
    let session: FireStoreSession
    
    init(session: FireStoreSession = DataSession()){
        self.session = session
    }
    
    func getQuote(callback: @escaping (Result<[Quote], NetworkError>) -> Void) {
        
        var quotes = [Quote]()
        session.getDocuments(dataRequest: DataRequest.citations.rawValue) { result, error in
            if result != nil {
                for dictionnary in result! {
                    let quote = Quote(authorName: dictionnary["author"] as! String, text: dictionnary["text"] as! String, category: dictionnary["category"] as! String)
                    quotes.append(quote)
                }
                callback(.success(quotes))
            } else {
                callback(.failure(NetworkError.errorOccured))
            }
        }
    }
    
    func getNewQuote(callback: @escaping (Result<[Quote], NetworkError>) -> Void) {
        
        var quotes = [Quote]()
        session.getNewDocuments(dataRequest: DataRequest.citations.rawValue) { result, error in
            if result != nil {
                for dictionnary in result! {
                    let quote = Quote(authorName: dictionnary["author"] as! String, text: dictionnary["text"] as! String, category: dictionnary["category"] as! String)
                    quotes.append(quote)
                }
                callback(.success(quotes))
            } else {
                callback(.failure(NetworkError.errorOccured))
            }
        }
    }
}
