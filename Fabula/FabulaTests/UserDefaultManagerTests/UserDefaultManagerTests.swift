//
//  UserDefaultManagerTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Foundation
@testable import Fabula


class UserDefaultsManagerTests: XCTestCase {
    
    private var userDefaults: UserDefaults!
    
    private var manager:  UserDefaultsManager!
    
    override func setUp() {
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        
        manager = UserDefaultsManager(userDefaults: userDefaults)
        
    }
    
    func testUserDefaultsManager_WhenAddOneFavorite_ThenUserDefaultCountEgalOne() {
        
        manager.saveFavorite(number: 1)
        
        let favCount = manager.retrieveFavCount()
        
        XCTAssert(favCount == 1)
    }
    
    func testUserDefaultsManager_WhenUserIsConnected_ThenWhenRetrieveEgalTrue() {
        
        manager.userIsConnected(true)
        
        let isConnected = manager.retrieveUserConnexion()
        
        XCTAssert(isConnected == true)
    }
    
    func testUserDefaultsManager_WhenNoUserConnected_ThenWhenRetrieveEgalFalse() {
        
        manager.deleteUserConnexion()
        let isConnected = manager.retrieveUserConnexion()
        
        XCTAssert(isConnected == false)
    }
    
    
    func testUserDefaultsManager_WhenUserIsSaved_ThenWhenRetrieveNameEgalUserName() {
        
        manager.saveUser(userName: "Bob", userId: "sergent", userEmail: "email")
        
        let user = manager.retrieveUser()
        
        XCTAssert(user?["userName"] == "Bob")
    }
    
    func testUserDefaultsManager_WhenDeleteUserInfo_ThenWhenRetrieveEgalNil() {
        
        manager.deleteUser()
        
        let user = manager.retrieveUser()
        
        XCTAssert(user == nil)
    }
    
    
}

