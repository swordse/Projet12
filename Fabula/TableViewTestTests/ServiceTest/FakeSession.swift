//
//  FakeSession.swift
//  TableViewTestTests
//
//  Created by Raphaël Goupille on 11/02/2022.
//

import Foundation
import Firebase
@testable import TableViewTest


struct FakeResponse {
    var result: [[String: Any]]?
    var error : NetworkError?
}

final class FakeWordSession: FireSession {

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
   
}
