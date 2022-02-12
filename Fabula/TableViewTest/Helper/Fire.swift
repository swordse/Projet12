//
//  Fire.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 22/01/2022.
//

import Foundation
import Firebase
import FirebaseAuth

struct Fire {
    
    /// FirebaseAuth create account. Use to create account, save user in userdefaults, save user in firebase
    /// - Parameters:
    ///   - userEmail: email
    ///   - password: password
    ///   - userName: userName
    ///   - completion: Result, Error
    static func createAccount(userEmail: String, password: String, userName: String, completion: @escaping(Result<AuthDataResult, Error>) -> Void) {
        // create user in Authentification
        Auth.auth().createUser(withEmail: userEmail, password: password) { result, error in
            guard error == nil else {
                // error during creation
                completion(.failure(error!))
                return
            }
            // creation OK
            // retrieveUser to get the id and save the new user in firebase "users"
            Fire.getCurrentUser { user in
                guard let user = user else {
                    return
                }
                Fire.saveUser(userName: userName, userId: user.uid, userEmail: userEmail)
                // save the state in userDefaults
                UserDefaultManager.userIsConnected(true)
                // save the new user in userDefaults
                UserDefaultManager.saveUser(userName: userName, userId: user.uid, userEmail: userEmail)
                completion(.success(result!))
            }
        }
    }
    
    static func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let result = result else {
                return
            }
            completion(.success(result))
        }
    }
    
    // retrieve the currentUser from FireAuthentification
    static func getCurrentUser(callBack: (FirebaseAuth.User?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            callBack(nil)
            return
        }
        callBack(currentUser)
    }
    
    static func getUserInfo (callBack: @escaping(User?) -> Void) {
        
        var user: User?
        
        getCurrentUser { currentUser in
            guard let currentUser = currentUser else {
                callBack(nil)
                return
            }
            let currentUserId = currentUser.uid
            print("currentUserId \(currentUserId)")
            let database = Firestore.firestore()
            
            let docRef = database.collection("users").whereField("userId", isEqualTo: currentUserId)
            
            docRef.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = snapshot?.documents, !documents.isEmpty else {
                        callBack(nil)
                        return
                    }
                    
                    guard let dictionary = snapshot?.documents[0].data() else {
                        callBack(nil)
                        return
                    }
                    user = User(userName: dictionary["userName"] as! String, userId: dictionary["userId"] as! String, userEmail: dictionary["userEmail"] as! String)
                    
                    
                    callBack(user)
                }
            }
        }
    }
    
    static func saveUser(userName: String, userId: String, userEmail: String) {
        
        let dataBase = Firestore.firestore()
        let docData: [String: Any] = [
            "userId": userId,
            "userName": userName,
            "userEmail": userEmail
        ]
        
        dataBase.collection("users").document().setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        // userdefault save logout
        UserDefaultManager.userIsConnected(false)
    }
    
}
