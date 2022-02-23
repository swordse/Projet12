//
//  QuoteViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Firebase
@testable import Fabula

class QuoteViewModelTests: XCTestCase {

    func testViewModelGetWords_WhenErrorOccured_ThenNoWordsToDisplay() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        quoteViewModel.quotesToDisplay = {
            result in
            switch result {
            case.failure(let error):
                XCTAssertEqual(error, NetworkError.errorOccured)
            case.success(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
        
        quoteViewModel.getQuotes()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testViewModelGetWords_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        quoteViewModel.quotesToDisplay = {
            result in
            switch result {
            case.failure(_):
                XCTFail("\(#function) failed")
            case.success(let success):
                XCTAssert(!success.isEmpty)
            }
            expectation.fulfill()
        }
        
        quoteViewModel.getQuotes()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetNewQuotes_WhenErrorOccured_ThenShouldNotReturnNeWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        quoteViewModel.quotesToDisplay = {
            result in
            switch result {
            case.failure(let error):
                XCTAssertEqual(error, NetworkError.errorOccured)
            case.success(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
        
        quoteViewModel.getNewQuotes()
        
        wait(for: [expectation], timeout: 0.1)
    }

    
    
    func testGetNewWords_WhenAllOk_ThenShouldReturnOneWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for closure.")
        
        quoteViewModel.quotesToDisplay = {
            result in
            switch result {
            case.failure(_):
                XCTFail("\(#function) failed")
            case.success(let success):
                XCTAssert(!success.isEmpty)
            }
            expectation.fulfill()
        }
        
        quoteViewModel.getNewQuotes()
        
        wait(for: [expectation], timeout: 0.1)
    }
    

}
