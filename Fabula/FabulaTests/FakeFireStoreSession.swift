//
//  FakeSession.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import Foundation
import Firebase
@testable import Fabula


struct FakeResponse {
    var result: [[String: Any]]?
    var error : NetworkError?
}

final class FakeFireStoreSession: FireStoreSession {

    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse){
        self.fakeResponse = fakeResponse
    }
    
    func getDocuments(dataRequest: String, callback: @escaping ([[String : Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
    
    func getNewDocuments(dataRequest: String, callback: @escaping ([[String : Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
    
    func getAllDocuments(dataRequest: String, callback: @escaping ([[String : Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
    
    
    func save(commentToSave: [String: Any], anecdoteId: String, completion: @escaping (Bool) -> ()) {
        completion(true)
    }
    
    func readComments(dataRequest: String, anecdoteId: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
    
    func getCategoryQuizz(dataRequest: String, callback: @escaping ([[String : Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
    
    func getQuizzs(title: String, dataRequest: String, callback: @escaping([[String : Any]]?, NetworkError?) -> Void) {
        callback(fakeResponse.result, fakeResponse.error)
    }
   
}
