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
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func testStart_WhenAllOK_ThenPropositionsClosureReturnPropositions() {
        
        sut.propositions =  {
            propositions in
            XCTAssert(propositions.count == 2)
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

}
