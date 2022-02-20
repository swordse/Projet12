//
//  UserAccountViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 15/02/2022.
//

import XCTest

import XCTest
import Firebase
@testable import Fabula


class UserAccountViewModelTests: XCTestCase, AuthentificationProtocol {
    
    var bool = false
    
    func statusChange(isConnected: Bool) {
        self.bool = isConnected
    }
    

    
    func testUserAccountViewModelCreateAccount_WhenNetWorkErrornoConnection_ThenNetWorkErrorIsPassed() {
        
        let session = FakeFireAuthSession(fakeAuthResponse: FakeAuthResponse(isSuccess: false, error: NetworkError.noConnection, fabulaUser: FakeAuthData.fakeUser))
        
        let authService = AuthService(session: session)
        
        let userAccountViewModel = UserAccountViewModel(authService: authService)
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        userAccountViewModel.accountCreationResult = {
            result in
            switch result {
            case.success(_):
                print("bob")
            case.failure(let networkError):
                XCTAssertEqual(networkError, NetworkError.noConnection)
            }
            expectation.fulfill()
        }
        
        userAccountViewModel.accountCreation(userEmail: FakeAuthData.fakeUser.userEmail, password: "zzzzz", userName: FakeAuthData.fakeUser.userName)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testUserAccountViewModelCreateAccount_WhenNoError_ThenSuccesIsPassed() {
        
        let session = FakeFireAuthSession(fakeAuthResponse: FakeAuthResponse(isSuccess: true, error: nil, fabulaUser: FakeAuthData.fakeUser))
        
        let authService = AuthService(session: session)
        
        let userAccountViewModel = UserAccountViewModel(authService: authService)
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        userAccountViewModel.accountCreationResult = {
            result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success, true)
            case.failure(_):
                print("bob")
            }
            expectation.fulfill()
        }
        
        userAccountViewModel.accountCreation(userEmail: FakeAuthData.fakeUser.userEmail, password: "zzzzz", userName: FakeAuthData.fakeUser.userName)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testUserAccountViewModelSignIn_WhenNoError_ThenSignInSucces() {
        
        let session = FakeFireAuthSession(fakeAuthResponse: FakeAuthResponse(isSuccess: true, error: nil, fabulaUser: FakeAuthData.fakeUser))
        
        let authService = AuthService(session: session)
        
        let userAccountViewModel = UserAccountViewModel(authService: authService)
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
       userAccountViewModel.signInResult = {
        result in
        switch result {
        case.success(let success):
            XCTAssertEqual(success, true)
        case.failure(_):
            print("bob")
        }
           expectation.fulfill()
    }
    
        userAccountViewModel.signIn(email: "dededed", passWord: "dedede")
    
    wait(for: [expectation], timeout: 0.1)
    }
    
    func testSignIn_WhenNoConnexion_ThenSignFailedWithNoConnectionError() {
        
        let session = FakeFireAuthSession(fakeAuthResponse: FakeAuthResponse(isSuccess: false, error: NetworkError.noConnection, fabulaUser: FakeAuthData.fakeUser))
        
        let authService = AuthService(session: session)
        
        let userAccountViewModel = UserAccountViewModel(authService: authService)
        
        let expectation = XCTestExpectation(description: "Wait for closure return.")
        
        userAccountViewModel.signInResult = {
            result in
            switch result {
            case.success(_):
                print("bob")
            case.failure(let networkError):
                XCTAssertEqual(networkError, NetworkError.noConnection)
            }
            expectation.fulfill()
        }
        
        userAccountViewModel.signIn(email: "dededed", passWord: "dedede")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLogOut_WhenAllOk_ThenSignFailedWithNoConnectionError() {
        
        let session = FakeFireAuthSession(fakeAuthResponse: FakeAuthResponse(isSuccess: false, error: NetworkError.noConnection, fabulaUser: FakeAuthData.fakeUser))
        
        let authService = AuthService(session: session)
        
        let userAccountViewModel = UserAccountViewModel(authService: authService)
        
        userAccountViewModel.logOut()
        XCTAssert(UserDefaultsManager().retrieveUserConnexion() == false)
  
    }
    

}
