//
//  ANecdoteCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 20/02/2022.
//

import XCTest
@testable import Fabula

class WordCoordinatorTests: XCTestCase {
    
        var wordCoordinator: WordCoordinator?
        
        override func setUpWithError() throws {
            wordCoordinator = WordCoordinator(navigationController: UINavigationController())
        }

        override func tearDownWithError() throws {
            wordCoordinator = nil
        }

    func testStart_WhenOK_ThenTopViewControllerIsAnecdotel() {
        
        wordCoordinator?.start()
        
        XCTAssert((wordCoordinator?.navigationController.topViewController as? WordViewController) != nil)
    }
    
    }
