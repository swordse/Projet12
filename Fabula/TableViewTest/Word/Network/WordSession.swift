//
//  QuoteService.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation
import FirebaseFirestore

protocol FireSession {
    
    func getDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void)
    
    func getNewDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void)
}

class WordSession: FireSession {
    
    var lastSnapshot: QueryDocumentSnapshot?
    
    let dataBase = Firestore.firestore()
    
    func getDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        
       
       let docRef = dataBase.collection(dataRequest).order(by: "date", descending: true).limit(to: 5)
        
        
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                callback(nil, NetworkError.errorOccured)
//                callback(.failure(NetworkError.errorOccured))
                return
            }
            
            if snapshot?.metadata.isFromCache == true {
                callback(nil, NetworkError.noConnection)
            }
            
            var dictionnary = [[String: Any]]()
            for x in 0 ..< data.count {
                dictionnary.append(data[x].data())
            }
            
            print("Dictionnary : \(dictionnary)")
            callback(dictionnary, nil)
//            callback(.success(dictionnary))
            
            self.lastSnapshot = snapshot?.documents.last
        }
    }
    
    func getNewDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        
        guard let lastSnapshot = lastSnapshot else {
            return
        }
        
        let docRef = dataBase.collection("words").order(by: "date", descending: true).limit(to: 5).start(afterDocument: lastSnapshot)
        
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                callback(nil, NetworkError.errorOccured)
//                callback(.failure(NetworkError.errorOccured))
                return
            }
            
            if snapshot?.metadata.isFromCache == true {
                callback(nil, NetworkError.noConnection)
            }
            
            var dictionnary = [[String: Any]]()
            for x in 0 ..< data.count {
                dictionnary.append(data[x].data())
            }
            
            print("Dictionnary : \(dictionnary)")
            callback(dictionnary, nil)
//            callback(.success(dictionnary))
            
            self.lastSnapshot = snapshot?.documents.last
            
        }
    }
}
