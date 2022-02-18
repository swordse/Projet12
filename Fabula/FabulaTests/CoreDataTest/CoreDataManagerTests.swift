////
////  CoreDataManagerTests.swift
////  FabulaTests
////
////  Created by Raphaël Goupille on 15/02/2022.
////
//
//import XCTest
//@testable import Fabula
//
//class CoreDataManagerTests: XCTestCase {
//
//        // MARK: - Properties
//
//        var coreDataStack: MockCoreDataStack!
//        var coreDataManager: CoreDataManager!
//
//        //MARK: - Tests Life Cycle
//
//        override func setUp() {
//            super.setUp()
//            coreDataStack = MockCoreDataStack()
//            coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
//        }
//
//        override func tearDown() {
//            super.tearDown()
//            coreDataManager = nil
//            coreDataStack = nil
//        }
//
//        // MARK: - Tests
//
//        func testCreateFavoriteMethods_WhenaFavoriteIsCreated_ThenShouldBeCorrectlySaved() {
//            coreDataManager.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
//            XCTAssertTrue(!coreDataManager.favorites.isEmpty)
//            XCTAssertTrue(coreDataManager.favorites.count == 1)
//            XCTAssertTrue(coreDataManager.favorites[0].text! == "text")
//        }
//
//        func testDeleteAllFavoritesMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
//            coreDataManager.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
//            coreDataManager.deleteAllFavorites()
//            XCTAssertTrue(coreDataManager.favorites.isEmpty)
//        }
//    
//    func testDeleteFavoriteMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
//        coreDataManager.createFavorite(anecdote: FakeResponseData.fakeAnecdote)
//        coreDataManager.deleteFavorite(anecdote: FakeResponseData.fakeAnecdote)
//        XCTAssertTrue(coreDataManager.favorites.isEmpty)
//    }
//    
//}
