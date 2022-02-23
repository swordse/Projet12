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
    }
    
    func testSearchViewModelGetAllAnecdotes_WhenAllOk_ThenAnecdotesNotNil() {

        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.getResultAnecdote(), error: nil))

        let searchService = AnecdoteService(session: session)

        let searchViewModel = SearchViewModel(searchService: searchService, delegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        let expectation = self.expectation(description: "closure return")

        let expectedResult = "Difforme"
        
        searchViewModel.allAnecdotes = {
result in
            switch result {
            case.failure(_):
                XCTFail("\(#function) failed")
            case.success(let success):
                XCTAssertEqual(success[0].title, expectedResult)
            }
            expectation.fulfill()
        }
        
        searchViewModel.getAllAnecdotes()

        waitForExpectations(timeout: 0.1, handler: nil)
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
    

}
