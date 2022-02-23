//
//  ANecdoteCoordinatorTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 20/02/2022.
//

import XCTest
@testable import Fabula

class AnecdoteCoordinatorTests: XCTestCase {
    
        var anecdoteCoordinator: AnecdoteCoordinator?
        
        override func setUpWithError() throws {
            anecdoteCoordinator = AnecdoteCoordinator(navigationController: UINavigationController())
        }

        override func tearDownWithError() throws {
            anecdoteCoordinator = nil
        }

    func testStart_WhenOK_ThenTopViewControllerIsAnecdotel() {
        
        anecdoteCoordinator?.start()
        
        XCTAssert((anecdoteCoordinator?.navigationController.topViewController as? AnecdoteViewController) != nil)
    }
    
        func testShowDetail_WhenOK_ThenTopViewControllerIsDetail() {
            
            anecdoteCoordinator?.showDetail(anecdote: Anecdote(id: "de'", categorie: Category.arts, title: "dede", text: "dede", source: "dede", date: "dede", isFavorite: false), commentIsTapped: false, isFavoriteNavigation: false)
            
            XCTAssert((anecdoteCoordinator?.navigationController.topViewController as? DetailAnecdoteTableViewController) != nil)
        }
    
    func testShowFavorite_WhenOK_ThenTopViewControllerIsFavorite() {
        
        anecdoteCoordinator?.showFavorite()
        
        XCTAssert((anecdoteCoordinator?.navigationController.topViewController as? FavoriteViewController) != nil)
    }
    
    func testShowSearch_WhenOK_ThenTopViewControllerIsSearch() {
        
        anecdoteCoordinator?.showSearch()
        
        XCTAssert((anecdoteCoordinator?.navigationController.topViewController as? SearchViewController) != nil)
    }
    
    func testStart_WhenShowDetailAndPopDetail_ThenTopViewControllerIsAnecdote() {
        
        anecdoteCoordinator?.start()
        
        anecdoteCoordinator?.showDetail(anecdote: Anecdote(id: "de'", categorie: Category.arts, title: "dede", text: "dede", source: "dede", date: "dede", isFavorite: false), commentIsTapped: false, isFavoriteNavigation: false)
        
        anecdoteCoordinator?.pop()
        
        XCTAssert((anecdoteCoordinator?.navigationController.topViewController as? AnecdoteViewController) != nil)
    }


    }
