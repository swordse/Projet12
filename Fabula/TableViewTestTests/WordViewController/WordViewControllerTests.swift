//
//  WordViewControllerTests.swift
//  TableViewTestTests
//
//  Created by Raphaël Goupille on 12/02/2022.
//

import XCTest
import Firebase
@testable import TableViewTest


final class WordViewControllerTests: XCTestCase {

func testViewControllerGetWords_WhenErrorOccured_ThenWordsCountEqualOne() {
    
    let session = FakeWordSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
    
    let wordService = WordService(session: session)
    
    let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
    
    let wordViewController = WordViewController()
    wordViewController.wordViewModel = wordViewModel
    
    let expectation = XCTestExpectation(description: "Wait for queue change.")
    
    wordViewController.wordViewModel?.getWords()
    
    XCTAssert(wordViewModel.words.count == 0)
    expectation.fulfill()
    wait(for: [expectation], timeout: 0.01)
}
    
    
}
