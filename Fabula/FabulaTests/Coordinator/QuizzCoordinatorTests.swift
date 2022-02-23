//
//  QuizzCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 21/02/2022.
//

import XCTest
@testable import Fabula

class QuizzCoordinatorTests: XCTestCase {
    
        var quizzCoordinator: QuizzCoordinator?
        
        override func setUpWithError() throws {
            quizzCoordinator = QuizzCoordinator(navigationController: UINavigationController())
        }

        override func tearDownWithError() throws {
            quizzCoordinator = nil
        }

    func testStart_WhenOK_ThenTopViewControllerIsQuizz() {
        
        quizzCoordinator?.start()
        
        XCTAssert((quizzCoordinator?.navigationController.topViewController as? HomeQuizzViewController) != nil)
    }
    
        func testShowTestQuizz_WhenOK_ThenTopViewControllerIsTestQuizz() {
            
            quizzCoordinator?.showQuizz(quizzs: [Quizz(category: "dede", propositions: ["dede", "dede", "dede"], question: "dede", response: "dede", title: "dede")])
            
            XCTAssert((quizzCoordinator?.navigationController.topViewController as? TestQuizzViewController) != nil)
        }
    
    func testShowFavorite_WhenShowQuizzAndPop_ThenTopViewControllerIsFavorite() {
        
        quizzCoordinator?.start()
        
        quizzCoordinator?.showQuizz(quizzs: [Quizz(category: "dede", propositions: ["dede", "dede", "dede"], question: "dede", response: "dede", title: "dede")])
        
        quizzCoordinator?.pop()
        
        XCTAssert((quizzCoordinator?.navigationController.topViewController as? HomeQuizzViewController) != nil)
    }
    

    }
