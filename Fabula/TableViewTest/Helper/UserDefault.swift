//
//  UserDefault.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 16/01/2022.
//

import Foundation

class UserDefaultManager {
   // MARK: - FAVORITE
    
    // save favorite count
    /// use to avoid to retrieve coreData each time we need the favorites count.
    /// - Parameter number: number of favorite save, we add or delete one each time the heart button is tapped
    static func saveFavorite(number: Int) {
        UserDefaults.standard.set(number, forKey: "favCount")
    }
    
    // get favorite count
    static func retrieveFavCount() -> Int {
        guard let favCount = UserDefaults.standard.object(forKey: "favCount") as? Int else { return 0 }
        return favCount
    }
    
    
    //MARK: - CONNEXION STATE
    // save connexion state
    static func userIsConnected(_ bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "isConnected")
    }
    
    // retrieve connexion state
    static func retrieveUserConnexion() -> Bool {
        guard let isConnected = UserDefaults.standard.object(forKey: "isConnected") as? Bool else {
            print("UserDefaults: Error when retrieve user connexion state")
            return false
        }
        return isConnected
    }
    
    // MARK: - USER
    static func saveUser(userName: String, userId: String, userEmail: String) {
        let userInfo = ["userId": userId, "userEmail": userEmail, "userName": userName]
        UserDefaults.standard.set(userInfo, forKey: "userInfo" )
    }
    
    static func retrieveUser() -> [String: String]? {
        guard let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? [String: String] else {
            return nil
        }
        return userInfo
    }
}
