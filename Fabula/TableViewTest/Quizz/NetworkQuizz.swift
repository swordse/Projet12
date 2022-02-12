//
//  NetworkQuizz.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/12/2021.
//

import Foundation
import FirebaseFirestore

class NetworkQuizz {
    
    let database = Firestore.firestore()
    
    func getCategory(callback: @escaping(Result<[[String: Any]], NetworkError>) -> Void) {
        print("NETWORK QUIZZ IS CALLED !!!!!!!!!!!!!")
        var firestoreResult = [[String: Any]]()
        let docRef = database.collection("categoryQuizz")
            docRef.getDocuments { snapshot, error in
                guard let data = snapshot?.documents
                        , error == nil else {
                            callback(.failure(NetworkError.errorOccured))
                            return
                        }
                print("*******DATA \(data)**********")
                if data.isEmpty {
                    callback(.failure(NetworkError.noData))
                    print("*****callback avec no data error passé dans la closure******")
                }
                for i in 0 ..< data.count {
                    let dictionary = data[i].data()
                    firestoreResult.append(dictionary)
                    print(firestoreResult)
                }
                
                callback(.success(firestoreResult))
            }
    }
    
    func getQuizz(title: String, callback: @escaping(Result<[QueryDocumentSnapshot], NetworkError>) -> Void) {
        let docRef = database.collection("quizzs").whereField("title", isEqualTo: title)
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                callback(.failure(NetworkError.errorOccured))
                return }
            
            if data.isEmpty {
                callback(.failure(NetworkError.noData))
            }
           print("data \(data)")
            callback(.success(data))
        }
    }
    
}
