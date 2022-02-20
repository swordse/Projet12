//
//  AuthService.swift
//  Fabula
//
//  Created by Raphaël Goupille on 14/02/2022.
//

import Foundation

class AuthService {
    
    let session: FireAuthSession
    
    init(session: FireAuthSession = AuthSession()) {
        self.session = session
    }
    
    func createAccount(userEmail: String, password: String, userName: String, completion: @escaping(Result<Bool, NetworkError>) -> Void) {
        
        session.createAccount(userEmail: userEmail, password: password, userName: userName) { isSuccess, networkError in
            if isSuccess {
                completion(.success(true))
            } else { guard let networkError = networkError else { return }
                completion(.failure(networkError))
            }
        }
    }
    
    func getCurrentUser(completion: ((FabulaUser?) -> Void)) {
        session.getCurrentUser { user in
            completion(user)
        }
    }
    
    func saveUser(user: FabulaUser) {
        session.saveUser(user: user)
    }
    
    func signIn(email: String, passWord: String, completion: @escaping ((Result<Bool, NetworkError>) -> Void)) {
        
        session.signIn(email: email, password: passWord) { isSucces, networkError in
            if isSucces {
                completion(.success(true))
            } else {
                guard let networkError = networkError else {
                    return
                }
                completion(.failure(networkError))
            }
        }
    }
        
        func logOut() {
            session.logOut()
        }
}
