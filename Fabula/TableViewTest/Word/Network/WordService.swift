//
//  WordService.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation

class WordService {
    
    let session: FireSession
    
    init(session: FireSession = WordSession()) {
        self.session = session
    }
    
    // call to get the initial words
    func getWords(dataRequest: String, callback: @escaping ((Result<[Word], NetworkError>) -> Void)) {
        
        var words = [Word]()
      
        session.getDocuments(dataRequest: DataRequest.words.rawValue) { result, error  in
            
            if result != nil {
                for dictionnary in result! {
                                    let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String)
                                    words.append(word)
                                }
                                callback(.success(words))
            }
            
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
            
//            switch result {
         //            case.success(let wordsResult):
         //
         //                for dictionnary in wordsResult {
         //                    let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String)
         //                    words.append(word)
         //                }
         //                callback(.success(words))
         //
         //            case.failure(let error):
         //                callback(.failure(error))
         //            }
        }
    }
    // call when tableview's bottom is reached
    func getNewWords (dataRequest: String, callback: @escaping ((Result<[Word], NetworkError>) -> Void)) {
        
        var words = [Word]()
        
        session.getNewDocuments(dataRequest: DataRequest.words.rawValue) { result, error in
            if result != nil {
                for dictionnary in result! {
                                    let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String)
                                    words.append(word)
                                }
                                callback(.success(words))
            }
            
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
            
//            switch result {
//            case.success(let wordsResult):
//
//                for dictionnary in wordsResult {
//                    let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String)
//                    words.append(word)
//                }
//                callback(.success(words))
//
//            case.failure(let error):
//                callback(.failure(error))
//            }
        }
    }
    
    
}
