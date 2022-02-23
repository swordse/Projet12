//
//  WordService.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation

final class WordService {
    
    let session: FireStoreSession
    
    init(session: FireStoreSession = DataSession()) {
        self.session = session }
    
    // call to get the initial words
    func getWords(dataRequest: String, callback: @escaping ((Result<[Word], NetworkError>) -> Void)) {
        
        var words = [Word]()
        
        session.getDocuments(dataRequest: DataRequest.words.rawValue) { result, error  in
            
            if result != nil {
                for dictionnary in result! {
                    let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String, qualifier: dictionnary["qualifier"] as! String, example: dictionnary["example"] as! String)
                    words.append(word)
                }
                callback(.success(words))
            }
            
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
        }
    }
    // call when tableview's bottom is reached
    func getNewWords (dataRequest: String, callback: @escaping ((Result<[Word], NetworkError>) -> Void)) {
        
        var words = [Word]()
        
        session.getNewDocuments(dataRequest: dataRequest) { result, error in
            if result != nil {
                for dictionnary in result! {              let word = Word(word: dictionnary["word"] as! String, definition: dictionnary["definition"] as! String, qualifier: dictionnary["qualifier"] as! String, example: dictionnary["example"] as! String)
                    words.append(word)
                }
                callback(.success(words))
            }
            
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            }
        }
    }
    
}
