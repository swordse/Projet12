//
//  Fire.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 22/01/2022.
//

import Foundation
import Firebase
import FirebaseAuth


protocol FireAuthSession {
    
    func createAccount(userEmail: String, password: String, userName: String, completion: @escaping (Bool, NetworkError?) -> Void)
    
    func signIn(email: String, password: String, completion: @escaping (Bool, NetworkError?) -> Void)
    
    func getCurrentUser(callBack: (FabulaUser?) -> Void)
    
    func saveUser(user: FabulaUser)
    
    func logOut()
}


final class AuthSession: FireAuthSession {
    
    /// FirebaseAuth create account. Use to create account, save user in userdefaults, save user in firebase
    /// - Parameters:
    ///   - userEmail: email
    ///   - password: password
    ///   - userName: userName
    ///   - completion: Result, Error
    func createAccount(userEmail: String, password: String, userName: String, completion: @escaping(Bool, NetworkError?) -> Void) {
        // create user in Authentification
        Auth.auth().createUser(withEmail: userEmail, password: password) { result, error in
            // error during creation
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case.invalidEmail:
                        completion(false, NetworkError.invalidEmail)
                    case.emailAlreadyInUse:
                        completion(false, NetworkError.emailAlreadyUsed)
                    case.networkError:
                        completion(false, NetworkError.noConnection)
                    case.wrongPassword:
                        completion(false, NetworkError.wrongPassWord)
                    default:
                        completion(false, NetworkError.errorOccured)
                    }
                }
            }
            else {
                // creation OK
                // add a displayName to the user
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                changeRequest?.commitChanges { error in
                    if error != nil {
                        print("Error when change displayName")
                    }
                }
                
                //                let changeRequest = result?.user.createProfileChangeRequest()
                //                changeRequest?.displayName = userName
                //                changeRequest?.commitChanges(completion: { error in
                //                    if error != nil {
                //                        print("Error when change displayName")
                //                    }
                //                })
                completion(true, nil)
            }
        }
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool, NetworkError?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case.invalidEmail:
                        completion(false, NetworkError.invalidEmail)
                    case.emailAlreadyInUse:
                        completion(false, NetworkError.emailAlreadyUsed)
                    case.networkError:
                        completion(false, NetworkError.noConnection)
                    case.wrongPassword:
                        completion(false, NetworkError.wrongPassWord)
                    default:
                        completion(false, NetworkError.errorOccured)
                    }
                }
            } else {
                completion(true, nil)
            }
        }
    }
    
    // retrieve the currentUser from FireAuthentification
    func getCurrentUser(callBack: (FabulaUser?) -> Void) {
        var user: FabulaUser?
        
        guard let currentUser = Auth.auth().currentUser else {
            callBack(nil)
            return
        }
        guard let email = currentUser.email else {
            user = nil
            return
        }
        let displayName = currentUser.displayName ?? ""
        user = FabulaUser(userName: displayName, userId: currentUser.uid, userEmail: email)
        
        callBack(user)
    }
    
    func saveUser(user: FabulaUser) {
        
        let dataBase = Firestore.firestore()
        let docData: [String: Any] = [
            "userId": user.userId,
            "userName": user.userName,
            "userEmail": user.userEmail
        ]
        
        dataBase.collection("users").document().setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        // userdefault save logout
        UserDefaultsManager().userIsConnected(false)
    }
    
}
