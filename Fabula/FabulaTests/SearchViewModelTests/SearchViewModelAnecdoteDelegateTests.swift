//
//  SearchViewModelAnecdoteDelegateTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 18/02/2022.
//

import XCTest
@testable import Fabula

class SearchViewModelAnecdoteDelegateTests: XCTestCase, AnecdoteDetailDelegate {
    
    var selectedAnecdote: Anecdote?
    
    func testAnecdoteDetailDelegate() throws {
        
        let manager = SearchViewModel(delegate: self)
        
        manager.searchResult = [FakeResponseData.fakeAnecdote]
        
        manager.selectedRow(int: 0)
        
        XCTAssert((selectedAnecdote?.title == "titre"))
    }
    
func getDetail(anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool) {
    self.selectedAnecdote = anecdote
}

}
