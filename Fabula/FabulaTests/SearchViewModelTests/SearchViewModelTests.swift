//
//  SearchViewModel.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Firebase
@testable import Fabula


class SearchViewModelTests: XCTestCase {

    func testSearchViewModelGetAllAnecdotes_WhenErrorOccured_ThenNoWordsToDisplay() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let searchService = AnecdoteService(session: session)
        
        let searchViewModel = SearchViewModel(searchService: searchService, delegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        searchViewModel.getAllAnecdotes()
        
        XCTAssert(searchViewModel.anecdotes.isEmpty)
//        let expectation = XCTestExpectation(description: "Wait closure.")
//
//        searchViewModel.allAnecdotes = {
//            result in
//            switch result {
//            case.success(_):
//                print("bob")
//            case.failure(let networkError):
//                XCTAssert(searchViewModel.anecdotes.isEmpty)
//            }
//            expectation.fulfill()
//        }
//
//        searchViewModel.getAllAnecdotes()
//
//        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchViewModelGetAllAnecdotes_WhenAllOk_ThenAnecdotesNotNil() {

        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))

        let searchService = AnecdoteService(session: session)

        let searchViewModel = SearchViewModel(searchService: searchService, delegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        let expectation = self.expectation(description: "closure return")
//                XCTAssertEqual(success[0].title, "Difforme")
//            }
//            expectation.fulfill()
//        }
    
//        searchViewModel.getAllAnecdotes()
        
        searchViewModel.allAnecdotes = {
result in
            switch result {
            case.failure(_):
                print("failure")
            case.success(let success):
                XCTAssert(!success.isEmpty)
            }
            expectation.fulfill()
        }
        
        searchViewModel.getAllAnecdotes()
//        XCTAssertEqual(searchViewModel.anecdotes.count, 1)

        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSearchInAnecdotesMethode_WhenAllOk_ThenAnecdotesResultIsNotEmpty() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))
        
        let searchService = AnecdoteService(session: session)
        
        let searchViewModel = SearchViewModel(searchService: searchService, delegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        searchViewModel.anecdotes = [FakeResponseData.fakeAnecdote]
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        searchViewModel.resultAnecdotes = {
            result in
            XCTAssert(!result.isEmpty)
            expectation.fulfill()
        }
        
        searchViewModel.searchInAnecdote(words: ["text"])
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchInAnecdotesMethode_WhenNoResultForSearch_ThenResultAnecdotesClosureIsEmpty() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))
        
        let searchService = AnecdoteService(session: session)
        
        let searchViewModel = SearchViewModel(searchService: searchService, delegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        searchViewModel.anecdotes = [Anecdote]()
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        searchViewModel.resultAnecdotes = {
            result in
            XCTAssert(result.isEmpty)
            expectation.fulfill()
        }
        
        searchViewModel.searchInAnecdote(words: ["text"])
        
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
