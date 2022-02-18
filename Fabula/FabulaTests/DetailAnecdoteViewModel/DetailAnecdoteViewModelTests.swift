//
//  DetailAnecdoteViewModelTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 15/02/2022.
//

import XCTest
import Foundation
@testable import Fabula

class DetailAnecdoteViewModelTests: XCTestCase {
        
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
    
    func testDetailAnecdoteGetComments_WhenAllOK_ThenCommentsContainsFakeComment() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultComment, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        detailAnecdoteViewModel.comments = {
            result in
            switch result {
            case.failure(_):
                print("failure")
            case.success(let comments):
                XCTAssertEqual(comments[0].commentText, "commentaire")
            }
            expectation.fulfill()
        }
        
        detailAnecdoteViewModel.getComments(id: "13")
        
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    
    func testDetailAnecdoteSaveComments_WhenAllOK_ThenCommentsContainsFakeComment() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultComment, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        UserDefaultsManager().saveUser(userName: "bob", userId: "dede", userEmail: "@gmail")
        
        detailAnecdoteViewModel.save(comment: "commentaire", anecdoteId: "13")
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        detailAnecdoteViewModel.comments = {
            result in
            switch result {
            case.failure(_):
                print("failure")
            case.success(let comments):
                XCTAssertEqual(comments[0].commentText, "commentaire")
            }
            expectation.fulfill()
        }
        
        detailAnecdoteViewModel.getComments(id: "13")
        
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    
    
    
    func testDetailAnecdoteGetComments_WhenError_ThenCommentsClosureReturnError() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
//        let detailAnecdoteViewModel = DetailAnecdoteViewModel(anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        let expectation = XCTestExpectation(description: "Wait for closure")
        
        detailAnecdoteViewModel.comments = {
            result in
            switch result {
            case.success(_):
                print("success")
            case.failure(let error):
                XCTAssertEqual(error, NetworkError.errorOccured)
            }
            expectation.fulfill()
        }
        
        detailAnecdoteViewModel.getComments(id: "13")
        
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testIsFavorite_WhenAnecdoteSearchedIsFavorite_ThenReturnTrue() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultComment, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        
        detailAnecdoteViewModel.favorites = [FakeResponseData.fakeAnecdote]
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        detailAnecdoteViewModel.isFavorite(anecdote: FakeResponseData.fakeAnecdote)
        
        XCTAssert(detailAnecdoteViewModel.anecdoteIsFavorite == true)
        
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testIsFavorite_WhenAnecdoteSearchedIsNotFavorite_ThenReturnFalse() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: FakeResponseData.resultComment, error: nil))
        
        let anecdoteService = AnecdoteService(session: session)
        
        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: CoreDataSession(coreDataStack: CoreDataStack()), anecdoteService: anecdoteService, showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        detailAnecdoteViewModel.favorites = [Anecdote]()
        
        detailAnecdoteViewModel.isFavorite(anecdote: FakeResponseData.fakeAnecdote)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        XCTAssert(detailAnecdoteViewModel.anecdoteIsFavorite == false)
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        
    }
  
    
    func testCoreDataSession_WhenNothing_ThenFavoritesIsEmpty() {

        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: coreDataSession, anecdoteService: AnecdoteService(), showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))

        XCTAssert(detailAnecdoteViewModel.coreDataSession.favorites.isEmpty)
    }
    
    func testSaveFavorite_WhenOK_ThenFavoritesIsNotEmpty() {

        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: coreDataSession, anecdoteService: AnecdoteService(), showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        detailAnecdoteViewModel.saveFavorite(anecdote: FakeResponseData.fakeAnecdote)

        XCTAssert(!detailAnecdoteViewModel.coreDataSession.favorites.isEmpty)
        XCTAssert(detailAnecdoteViewModel.coreDataSession.favorites[0].title == "titre")
    }
    
    func testDeleteFavorite_WhenOK_ThenFavoritesIsEmpty() {

        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: coreDataSession, anecdoteService: AnecdoteService(), showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        detailAnecdoteViewModel.saveFavorite(anecdote: FakeResponseData.fakeAnecdote)
        
        detailAnecdoteViewModel.deleteFavorite(anecdote: FakeResponseData.fakeAnecdote)

        XCTAssert(detailAnecdoteViewModel.coreDataSession.favorites.isEmpty)
    }
    
    func testGetFavorite_WhenOK_ThenFavoritesIsNotEmpty() {

        let detailAnecdoteViewModel = DetailAnecdoteViewModel(coreDataSession: coreDataSession, anecdoteService: AnecdoteService(), showFavoriteDelegate: AnecdoteCoordinator(navigationController: UINavigationController()))
        
        detailAnecdoteViewModel.saveFavorite(anecdote: FakeResponseData.fakeAnecdote)
        
        detailAnecdoteViewModel.getFavorite()

        XCTAssert(!detailAnecdoteViewModel.favorites.isEmpty)
    }
   

}
