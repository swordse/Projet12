//
//  TestQuizzTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 16/02/2022.
//

import XCTest
@testable import Fabula

class TestQuizzTests: XCTestCase {

    var sut: TestQuizzViewModel!
    
    override func setUpWithError() throws {
        
        sut = TestQuizzViewModel(quizzs: FakeResponseData.fakeQuizz)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    
    func testStart_WhenAllOK_ThenPropositionsClosureReturnPropositions() {
        
//        let expectation = self.expectation(description: "closure return")
        
        sut.propositions =  {
            propositions in
            XCTAssert(propositions.count == 2)
//            expectation.fulfill()
        }
        
        sut.question = {
            question in
            XCTAssert(question == "est ce que oui")
        }
        
        sut.progressBarProgress = {
            number in
            XCTAssertEqual(number, 0)
        }
        
    
        sut.start()
        
//        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testIsCorrect_WhenAllOK_ThenPropositionsClosureReturnIsCorrectDisplayedScorePlus1() {
        
        sut.correctAnswer = "oui"
        
        sut.isCorrect =  {
            isCorrect in
            XCTAssert(isCorrect)
        }
        
        sut.displayedScore =  {
            dislayedScore in
            XCTAssertEqual(dislayedScore, 1)
        }

        sut.isCorrect(playerResponse: "oui")

    }
    
    func testIsCorrect_WhenWrongAnswer_ThenPropositionsClosureReturnIsCorrectFalseDisplayedScoreIdem() {
        
        sut.correctAnswer = "non"
        
        sut.isCorrect =  {
            isCorrect in
            XCTAssert(!isCorrect)
        }
        
        sut.displayedScore =  {
            dislayedScore in
            XCTAssertEqual(dislayedScore, 0)
        }

        sut.isCorrect(playerResponse: "oui")

    }
    
    func testNextQuestion_WhenLastQuestion_ThenIsOnGoinGClosureReturnFalse() {
        
        sut.questionNumber = 1
        
        sut.isOngoing =  {
            isOnGoing in
            XCTAssert(!isOnGoing)
        }
        
        sut.nextQuestion()
    
    }
    
    func testNextQuestion_WhenNotLastQuestion_ThenIsOnGoinGClosureReturnTrue() {
        
        sut.questionNumber = 0
        
        sut.isOngoing =  {
            isOnGoing in
            XCTAssert(isOnGoing)
        }
        
        sut.nextQuestion()
    
    }
    
    func testEndGame_WhenAllOk_ThenProgressBarProgressClosureReturn1() {
        
        sut.progressBarProgress =  {
            number in
            XCTAssert(number == 1)
        }
        
        sut.endGame()
    
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
