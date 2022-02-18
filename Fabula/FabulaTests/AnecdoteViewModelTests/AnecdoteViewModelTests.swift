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
                print("success")
            case.failure(let networkError):
                XCTAssertEqual(networkError, expectedResult)
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getAnecdotes()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    
    func testViewModelGetAnecdotesMethod_WhenAllOk_ThenAnecdoteToDisplayClosureReturnAnecdotes() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultAnecdote, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = "Hello"
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.anecdotesToDisplay = { result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0].title, expectedResult)
            case.failure(_):
                print("dedede")
                
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getAnecdotes()
        
        waitForExpectations(timeout: 1, handler: nil)
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
                print("PAS DE SUCCES")
            case.failure(let networkError):
                XCTAssertEqual(networkError, expectedResult)
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getNewAnecdotes()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testViewModelGetNewAnecdotesMethod_WhenAllOk_ThenAnecdoteToDisplayClosureReturnAnecdotes() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultAnecdote, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectedResult = "Hello"
        
        let expectation = self.expectation(description: "closure return")
        
        anecdoteViewModel.anecdotesToDisplay = { result in
            switch result {
            case.success(let success):
                XCTAssertEqual(success[0].title, expectedResult)
            case.failure(_):
                print("dedede")
            }
            expectation.fulfill()
        }
        
        anecdoteViewModel.getNewAnecdotes()
        
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
