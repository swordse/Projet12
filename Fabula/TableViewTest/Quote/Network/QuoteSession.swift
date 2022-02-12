//
//  QuoteSession.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import Foundation
import FirebaseFirestore

//protocol FireStoreSession {
//
//    func getDocuments(callback: @escaping (QuerySnapshot?, Error?) -> Void)
//}

class QuoteSession: FireSession {
    
    var lastSnapshot: QueryDocumentSnapshot?
    
    let dataBase = Firestore.firestore()
    
    func getDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        
        let docRef = dataBase.collection("citations").order(by: "date", descending: true).limit(to: 5)
        
//        if lastSnapshot == nil {
//            docRef = dataBase.collection("citations").order(by: "date", descending: true).limit(to: 5)
//        } else {
//            docRef = dataBase.collection("citations").order(by: "date", descending: true).limit(to: 5).start(afterDocument: lastSnapshot!)
//        }
        
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                callback(nil, NetworkError.errorOccured)
                return
            }
            
            var dictionnary = [[String: Any]]()
            for x in 0 ..< data.count {
                dictionnary.append(data[x].data())
            }
            
            callback(dictionnary, nil)
            
            self.lastSnapshot = snapshot?.documents.last
        }
    }
    
    func getNewDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        
        guard let lastSnapshot = lastSnapshot else {
            return
        }
        
        let docRef = dataBase.collection("citations").order(by: "date", descending: true).limit(to: 5).start(afterDocument: lastSnapshot)
        
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
