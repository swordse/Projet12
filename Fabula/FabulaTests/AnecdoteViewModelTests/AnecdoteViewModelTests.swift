//
//  AnecdoteViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Foundation
@testable import Fabula

class AnecdoteViewModelTests: XCTestCase {
    
    func testViewModelGetAnecdotesMethod_WhenErrorOccured_ThenAnecdoteToDisplayClosureReturnError() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = NetworkError.errorOccured
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.anecdotesToDisplay = { result in
            switch result {
            case.success(_):
                XCTFail("\(#function) failed")
            case.failure(let networkError):
                XCTAssertEqual(networkError, expectedResult)
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getAnecdotes()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    
    func testViewModelGetAnecdotesMethod_WhenAllOk_ThenAnecdoteToDisplayClosureReturnAnecdotes() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = "Difforme"
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.anecdotesToDisplay = { result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0].title, expectedResult)
            case.failure(_):
                XCTFail("\(#function) failed")
                
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getAnecdotes()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModelGetNewAnecdotesMethod_WhenErrorOccured_ThenAnecdoteToDisplayClosureReturnError() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = NetworkError.errorOccured
        
        let expectation = XCTestExpectation(description: "Closure return")
        
        anecdoteViewModel.anecdotesToDisplay =  {
            result in
            switch result {
            case.success(_):
                XCTFail("\(#function) failed")
            case.failure(let networkError):
                XCTAssertEqual(networkError, expectedResult)
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getNewAnecdotes()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testViewModelGetNewAnecdotesMethod_WhenAllOk_ThenAnecdoteToDisplayClosureReturnAnecdotes() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = "Difforme"
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.anecdotesToDisplay = { result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0].title, expectedResult)
            case.failure(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getNewAnecdotes()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testGetFavNumber_WhenFavIs1_ThenNumberOfFavoritesClosureReturn1() {
        
        let anecdoteViewModel = AnecdoteViewModel(delegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        UserDefaultsManager().saveFavorite(number: 1)
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.numberOfFavorites = {
            number in
            XCTAssertEqual(number, 1)
            expectation.fulfill()
        }
        
        anecdoteViewModel.getFavNumber()
        waitForExpectations(timeout: 0.1, handler: nil)
    }

   
}
