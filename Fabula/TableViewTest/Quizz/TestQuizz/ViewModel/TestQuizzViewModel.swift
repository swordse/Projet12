//
//  QuizzTestViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import Foundation

final class TestQuizzViewModel {
    
    var quizzs: [Quizz]
    // variables to keep track of the game state
    var correctAnswer = ""
    var questionNumber = 0
    var score = 0
    
    init(quizzs: [Quizz]) {
        self.quizzs = quizzs
    }
    
    //    MARK: - Output
    var propositions: (([String]) -> Void)?
    var question: ((String) -> Void)?
    var isCorrect: ((Bool) -> Void)?
    var displayedScore :((Int) -> Void)?
    var isOngoing: ((Bool) -> Void)?
    var progressBarProgress: ((Float) -> Void)?
    
    //    MARK: - Methods
    // call to start new game or if the game is ongoing
    func start() {
        let firstPropositions = quizzs[questionNumber].propositions
        propositions?(firstPropositions)
        let firstQuestion = quizzs[questionNumber].question
        question?(firstQuestion)
        correctAnswer = quizzs[questionNumber].response
        progressBarProgress?(Float(Double(questionNumber)/10))
        displayedScore?(score)
    }
    // check if answer is correct
    func isCorrect(playerResponse: String) -> Void {
        if playerResponse == correctAnswer {
            isCorrect?(true)
            score += 1
            displayedScore?(score)
            nextQuestion()
        } else {
            isCorrect?(false)
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        self.questionNumber += 1
        if self.questionNumber < self.quizzs.count {
            self.start()
            self.isOngoing?(true)
        } else {
            self.progressBarProgress?(1)
            self.isOngoing?(false)
            self.endGame()
        }
    }
    
    func endGame() {
        question?("Correct: \(score)\nIncorrect: \(quizzs.count - score)")
        questionNumber = 0
        score = 0
    }
}
