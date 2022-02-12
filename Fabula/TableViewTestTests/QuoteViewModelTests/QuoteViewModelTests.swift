

import XCTest
import Firebase
@testable import TableViewTest


final class QuoteViewModelTests: XCTestCase {
    
    
    func testViewModelGetWords_WhenErrorOccured_ThenNoWordsToDisplay() {
        
        let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testViewModelGetWords_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 1)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewWords_WhenErrorOccured_ThenShouldNotReturnNeWord() {
        let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getNewQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }

    
    
    func testGetNewWords_WhenAllOk_ThenShouldReturnOneWord() {
        let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultQuote, error: nil))
        
        let quoteService = QuoteService(session: session)
        
        let quoteViewModel = QuoteViewModel(quoteService: quoteService, quotes: [Quote]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        quoteViewModel.getNewQuotes()
        
        XCTAssert(quoteViewModel.quotes.count == 1)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
}
