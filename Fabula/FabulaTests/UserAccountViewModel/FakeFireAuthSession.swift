//
//  FakeFireAuth.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 14/02/2022.
//

import Foundation
import Firebase
import FirebaseAuth
@testable import Fabula

struct FakeAuthResponse {
    var isSuccess: Bool
    var error: NetworkError?
    var fabulaUser: FabulaUser?
}

final class FakeFireAuthSession: FireAuthSession {
    
    private let fakeAuthResponse: FakeAuthResponse
    
    init(fakeAuthResponse: FakeAuthResponse) {
        self.fakeAuthResponse = fakeAuthResponse
    }
    
    func createAccount(userEmail: String, password: String, userName: String, completion: @escaping (Bool, NetworkError?) -> Void) {
        completion(fakeAuthResponse.isSuccess, fakeAuthResponse.error)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, NetworkError?) -> Void) {
        completion(fakeAuthResponse.isSuccess, fakeAuthResponse.error)
    }
    
    func getCurrentUser(callBack: (FabulaUser?) -> Void) {
        callBack(fakeAuthResponse.fabulaUser)
    }
    
    func saveUser(user: FabulaUser){
        
    }
    
    func logOut(){
    }


}
