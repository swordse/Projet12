//
//  HomeCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 20/02/2022.
//

import XCTest
@testable import Fabula

class HomeCoordinatorTests: XCTestCase {

    var homeCoordinator: HomeCoordinator?
    
    override func setUpWithError() throws {
        homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        homeCoordinator = nil
    }

    func testShowAnecdotes_WhenOK_ThenChildCoordinatorContainsAnecdoteCoordinator() {
        
        homeCoordinator?.showAnecdotes()
        
        XCTAssert(((homeCoordinator?.childCoordinators[0] as? AnecdoteCoordinator) != nil))
        
    }

    func testShowQuizz_WhenOK_ThenChildCoordinatorContainsQuizzCoordinator() {
        
        homeCoordinator?.showQuizz()
        
        XCTAssert(((homeCoordinator?.childCoordinators[0] as? QuizzCoordinator) != nil))
        
    }
    
    func testShowWord_WhenOK_ThenChildCoordinatorContainsWordCoordinator() {
        
        homeCoordinator?.showWord()
        
        XCTAssert(((homeCoordinator?.childCoordinators[0] as? WordCoordinator) != nil))
        
    }
    
    func testShowQuote_WhenOK_ThenChildCoordinatorContainsWordCoordinator() {
        
        homeCoordinator?.showQuote()
        
        XCTAssert(((homeCoordinator?.childCoordinators[0] as? QuoteCoordinator) != nil))
        
    }
    
    func testShowMap_WhenOK_ThenChildCoordinatorContainsWordCoordinator() {
        
        homeCoordinator?.showMap()
        
        XCTAssert(((homeCoordinator?.childCoordinators[0] as? MapCoordinator) != nil))
    }
    

}
