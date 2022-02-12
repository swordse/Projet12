//
//  QuoteNetWork.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import Foundation


class QuoteService {
    
    let session: FireSession
    
    init(session: FireSession = QuoteSession()){
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
            }
        }
    }
            
//            guard let data = snapshot?.documents, error == nil else {
//                callback(.failure(NetworkError.errorOccured))
//                return
//            }
//
//
//            for i in 0 ..< data.count {
//                let dictionnary = data[i].data()
//                let quote = Quote(authorName: dictionnary["author"] as! String, text: dictionnary["text"] as! String, category: dictionnary["category"] as! String)
//                quotes.append(quote)
//            }
//            callback(.success(quotes))
//        }
//    }
    
    
    
    
}
