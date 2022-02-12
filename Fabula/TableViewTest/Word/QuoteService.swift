//
//  QuoteService.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation
import FirebaseFirestore

protocol FireSession {
    
    func getDocuments(callback: @escaping (Result<[[String: Any]], Error>) -> Void)
}

class WordSession: FireSession {
    
    
    func getDocuments(callback: @escaping (Result<[[String: Any]], Error>) -> Void) {
        
        let dataBase = Firestore.firestore()
        
        let docRef = dataBase.collection("words")
        
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                callback(.failure(error!))
                return
            }
            var dictionnary = [[String: Any]]()
            for x in 0 ..< data.count {
                dictionnary.append(data[x].data())
            }
            callback(.success(dictionnary))
        }
    }
}
