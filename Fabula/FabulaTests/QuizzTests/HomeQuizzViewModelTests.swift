//
//  HomeQuizzViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 16/02/2022.
//

import XCTest
import Foundation
@testable import Fabula


class HomeQuizzViewModelTests: XCTestCase, QuizzGetTest {
    
    var quizzs: [Quizz]?
    
    func getTest(quizzs: [Quizz]) {
        self.quizzs = quizzs
    }
    
    func testViewModelRetrieveCategoryMethod_WhenErrorOccured_ThenThemeClosureReturnError() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: QuizzCoordinator(navigationController: UINavigationController()))
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.theme = {
            result in
            switch result {
            case.success(_):
                print("success")
            case.failure(let error):
                XCTAssertEqual(error, NetworkError.errorOccured)
            }
            expectation.fulfill()
        }
        
        homeQuizzViewModel.retrieveCategory()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelRetrieveCategoryMethod_WhenAllOK_ThenThemeClosureReturnTheme() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeCategory, error: nil))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: self)
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.theme = {
            result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0][0], "BILBO")
            case.failure(_):
                print("failure")
            }
            expectation.fulfill()
        }
        
        homeQuizzViewModel.retrieveCategory()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelRetrieveCategoryMethod_WhenAllOK_ThenCategoriesClosureReturnCategory() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeCategory, error: nil))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: QuizzCoordinator(navigationController: UINavigationController()))
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.categories = {
            result in
            XCTAssert(!result.isEmpty)
            expectation.fulfill()
        }
        
        homeQuizzViewModel.retrieveCategory()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelRetrieveQuizzMethod_WhenAllOK_ThenQuizzsIsFilled() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeQuizzData, error: nil))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: self)
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.retrieveQuizz(theme: "La lune")
        
        XCTAssertEqual(homeQuizzViewModel.quizzs[0].title, "La lune")
        XCTAssertEqual(quizzs?[0].title
                       , "La lune")
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    
    func testViewModelSelectedThemeMethod_WhenAllOK_ThenQuizzsIsFilled() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeQuizzData, error: nil))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: QuizzCoordinator(navigationController: UINavigationController()))
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.selectedTheme(theme: "La lune")
        
        XCTAssertEqual(homeQuizzViewModel.quizzs[0].title, "La lune")
        expectation.fulfill()
        
        waitForExpectations(timeout: 0.1, handler: nil)
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
