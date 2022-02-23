//
//  WordViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Firebase
@testable import Fabula


final class WordViewModelTests: XCTestCase {

    
    func testViewModelGetWords_WhenErrorOccured_ThenClosureWordToDisplayReturnFailure() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Closure return.")
        
        wordViewModel.getWords()
        
        wordViewModel.wordsToDisplay = { result in
            switch result {
            case.failure(let networkError):
                XCTAssertEqual(networkError, NetworkError.errorOccured)
            case.success(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
        
        wordViewModel.getWords()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testViewModelGetWords_WhenAllOk_ThenWordToDisplayClosureReturnWords() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Closure return.")
        
        wordViewModel.wordsToDisplay = { result in
            switch result {
            case.failure(_):
                XCTFail("\(#function) failed")
            case.success(let success):
                XCTAssert(!success.isEmpty)
            }
            expectation.fulfill()
        }
        
        wordViewModel.getWords()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testViewModelGetWords_WhenAllOk_ThenWordsToDisplayShouldReturnOneWord() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        wordViewModel.getWords()
        
        XCTAssert(wordViewModel.words.count == 1)
    }
    
    func testGetNewWords_WhenErrorOccured_ThenShouldNotReturnNeWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.wordsToDisplay = {
            result in
            switch result {
            case.success(_):
                XCTFail("\(#function) failed")
            case.failure(let networkError):
                XCTAssertEqual(networkError, NetworkError.errorOccured)
            }
            expectation.fulfill()
        }
    
        wordViewModel.getNewWords()
        
        wait(for: [expectation], timeout: 0.1)
    }

    
    
    func testGetNewWords_WhenAllOk_ThenShouldReturnOneWord() {
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultWord, error: nil))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewModel.wordsToDisplay = {
            result in
            switch result {
            case.success(let words):
                XCTAssertEqual(words[0].word, "DEFINITION")
            case.failure(_):
                XCTFail("\(#function) failed")
            }
            expectation.fulfill()
        }
    
        wordViewModel.getNewWords()
        
        wait(for: [expectation], timeout: 0.01)
    }


}
