//
//  QuizzService.swift
//  Fabula
//
//  Created by Raphaël Goupille on 16/02/2022.
//

import Foundation
import FirebaseFirestore


class QuizzService {
    
    let session: FireStoreSession
    
    init(session: FireStoreSession = DataSession()) {
        self.session = session
    }
    
    func getCategoryQuizz(callback: @escaping (Result<[[String: Any]], NetworkError>) -> Void) {
        session.getCategoryQuizz(dataRequest: DataRequest.categoryQuizz.rawValue) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
                print("ERROR IN QUIZZSERVICE TO GET CATEGORY")
            } else if result != nil {
                callback(.success(result!))
            }
        }
    }
    
    func getQuizzs(title: String, callback: @escaping (Result<[[String: Any]], NetworkError>) -> Void) {
        session.getQuizzs(title: title, dataRequest: DataRequest.quizzs.rawValue) { result, error in
            if error != nil {
                callback(.failure(NetworkError.errorOccured))
            } else {
                callback(.success(result!))
                print("RESULT IN QUIZZSERVICE: \(String(describing: result))")
            }
        }
    }
    
}
