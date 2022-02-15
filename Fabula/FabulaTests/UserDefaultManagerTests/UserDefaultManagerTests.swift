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
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

