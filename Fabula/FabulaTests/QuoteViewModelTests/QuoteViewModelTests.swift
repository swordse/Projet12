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
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testViewModelGetWords_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 1)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewWords_WhenErrorOccured_ThenShouldNotReturnNeWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getNewQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }

    
    
    func testGetNewWords_WhenAllOk_ThenShouldReturnOneWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getNewQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 1)
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
