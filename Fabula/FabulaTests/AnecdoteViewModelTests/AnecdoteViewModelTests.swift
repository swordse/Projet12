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
    
    func testViewModelGetAnecdotes_WhenErrorOccured_ThenNoAnecdoteToDisplay() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        anecdoteViewModel.getAnecdotes()
        
        XCTAssert(anecdoteViewModel.anecdotes.count == 0)
        
        XCTAssert(anecdoteViewModel.anecdotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testViewModelGetAnecdotes_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultAnecdote, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        anecdoteViewModel.getAnecdotes()
    
        XCTAssert(anecdoteViewModel.anecdotes.count == 1)
        XCTAssert(anecdoteViewModel.anecdotes[0].text == "le texte")
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testViewModelGetNewAnecdotes_WhenErrorOccured_ThenNoAnecdoteToDisplay() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        anecdoteViewModel.getNewAnecdotes()
        
        XCTAssert(anecdoteViewModel.anecdotes.count == 0)
        
        
        XCTAssert(anecdoteViewModel.anecdotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testViewModelGetNewAnecdotes_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultAnecdote, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let anecdoteViewModel = AnecdoteViewModel(anecdoteService: anecdoteService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        anecdoteViewModel.getNewAnecdotes()
    
        XCTAssert(anecdoteViewModel.anecdotes.count == 1)
        XCTAssert(anecdoteViewModel.anecdotes[0].text == "le texte")
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
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
