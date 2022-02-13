//
//  FireProtocol.swift
//  Fabula
//
//  Created by Raphaël Goupille on 12/02/2022.
//

import Foundation

protocol FireSession {
    
    func getDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void)
    
    func getNewDocuments(dataRequest: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void)
    
    func getUserInfo(dataRequest: String, userId: String, callback: @escaping ([String: Any]?, NetworkError?) -> Void)
    
    func readComments(dataRequest: String, anecdoteId: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void)
}

extension FireSession {
    func getUserInfo(dataRequest: String, userId: String, callback: @escaping ([String: Any]?, NetworkError?) -> Void) {
        print("getUserInfo")
    }
    
    func readComments(dataRequest: String, anecdoteId: String, callback: @escaping ([[String: Any]]?, NetworkError?) -> Void) {
        print("readComments")
    }
    
}
