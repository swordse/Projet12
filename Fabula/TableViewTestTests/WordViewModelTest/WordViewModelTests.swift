

import XCTest
import Firebase
@testable import TableViewTest


final class WordViewModelTests: XCTestCase {
    
    
    func testViewModelGetWords_WhenErrorOccured_ThenNoWordsToDisplay() {
        
        let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.getWords()
        
        XCTAssert(wordViewModel.words.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testViewModelGetWords_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.getWords()
        
        XCTAssert(wordViewModel.words.count == 1)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewWords_WhenErrorOccured_ThenShouldNotReturnNeWord() {
        let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.getNewWords()
        
        XCTAssert(wordViewModel.words.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }

    
    
    func testGetNewWords_WhenAllOk_ThenShouldReturnOneWord() {
        let session = FakeWordSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.getNewWords()
        
        XCTAssert(wordViewModel.words.count == 1)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
}
