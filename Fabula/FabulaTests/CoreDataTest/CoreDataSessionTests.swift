//
//  CoreDataServiceTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 17/02/2022.
//

import XCTest
@testable import Fabula

class CoreDataSessionTests: XCTestCase {

    
    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataSession: CoreDataSession!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataSession = CoreDataSession(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataSession = nil
        coreDataStack = nil
    }
    
    func testCreateFavoriteMethods_WhenaFavoriteIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataSession.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
        XCTAssertTrue(!coreDataSession.favorites.isEmpty)
        XCTAssertTrue(coreDataSession.favorites.count == 1)
        XCTAssertTrue(coreDataSession.favorites[0].text! == "text")
    }

    func testDeleteAllFavoritesMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataSession.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
        coreDataSession.deleteAllFavorites()
        XCTAssertTrue(coreDataSession.favorites.isEmpty)
    }

func testDeleteFavoriteMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
    coreDataSession.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
    coreDataSession.deleteFavorite(anecdote: FakeResponseData.fakeAnecdote)
    XCTAssertTrue(coreDataSession.favorites.isEmpty)
}
   

}
