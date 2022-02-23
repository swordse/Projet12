//
//  FavoriteViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 17/02/2022.
//

import XCTest
import Foundation
@testable import Fabula

class FavoriteViewModelTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataSession: CoreDataService!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataSession = CoreDataService(coreDataStack: coreDataStack)
    }

    func testGetFavorite_WhenOK_ThenFavoriteAnecdoteClosureReturnAnecdote() {

        let favoriteViewModel = FavoriteViewModel(coreDataSession: coreDataSession, anecdoteDetailDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        coreDataSession.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
        
        let expectation = XCTestExpectation(description: "Wait FavoriteAnecdote closure")
        
        favoriteViewModel.favoriteAnecdote = {
            anecdotes in
            XCTAssert(!anecdotes.isEmpty)
            expectation.fulfill()
        }
        
        favoriteViewModel.getFavorite()
        
        wait(for: [expectation], timeout: 0.1)
    }

}
