//
//  FavoriteAnecoteDelegate.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 18/02/2022.
//

import XCTest
@testable import Fabula

class FavoriteAnecdoteDelegateTests: XCTestCase, AnecdoteDetailDelegate {
    
    var anecdote: Anecdote?
    
    func testComment() throws {
        
        let manager = FavoriteViewModel(anecdoteDetailDelegate: self)
        
        let fakeAnecdote = FakeResponseData.fakeAnecdote
        manager.selectedRow(anecdote: fakeAnecdote, commentIsTapped: false, isFavoriteNavigation: false)
        
        XCTAssertEqual(anecdote!.title, "titre")
    }
    
    func getDetail(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        self.anecdote = anecdote
    }


}
