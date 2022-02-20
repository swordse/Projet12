//
//  AnecdoteDelegateTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 18/02/2022.
//

import XCTest
@testable import Fabula

class AnecdoteDelegateTests: XCTestCase, AnecdoteDetailDelegate {

        var selectedAnecdote: Anecdote?
        
        func testComment() throws {
            
            let manager = AnecdoteViewModel(delegate: self)
            
            manager.resultMapped = [FakeResponseData.fakeAnecdote]
            
            manager.selectedRow(row: 0, commentIsTapped: false, isFavoriteNavigation: false)
            
            XCTAssert((selectedAnecdote?.title == "titre"))
        }
        
    func getDetail(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
        self.selectedAnecdote = anecdote
    }

}
