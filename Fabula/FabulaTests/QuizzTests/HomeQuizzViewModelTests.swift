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
                XCTFail("\(#function) failed")
            case.failure(let error):
                XCTAssertEqual(error, NetworkError.errorOccured)
            }
            expectation.fulfill()
        }
        
        homeQuizzViewModel.retrieveCategory()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelRetrieveCategoryMethod_WhenAllOK_ThenThemeClosureReturnTheme() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeArtCategory, error: nil))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: self)
        
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.theme = {
            result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0][0], "BILBO")
            case.failure(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
        
        homeQuizzViewModel.retrieveCategory()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelRetrieveCategoryMethod_WhenAllOK_ThenCategoriesClosureReturnCategory() {
        
        for x in 0..<FakeResponseData.fakeCategories.count {
            
            let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.fakeCategories[x], error: nil))
        
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

    func testViewModelRetrieveQuizzMethod_WhenError_ThenQuizzsIsEmpty() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quizzService = QuizzService(session: session)
        
        let homeQuizzViewModel = HomeQuizzViewModel(quizzService: quizzService, delegate: self)
        
        homeQuizzViewModel.quizzs = [Quizz]()
        let expectation = self.expectation(description: "closure return")
        
        homeQuizzViewModel.retrieveQuizz(theme: "La lune")
        
        XCTAssert(homeQuizzViewModel.quizzs.isEmpty)
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


}
