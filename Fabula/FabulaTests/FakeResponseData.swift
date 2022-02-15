//
//  FakeResponseData.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import Foundation
@testable import Fabula

final class FakeResponseData {
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static let resultWord = [["definition": "ce qui définit" as Any, "word": "DEFINITION" as Any]]
    
    static let resultQuote = [["author": "bob", "text": "le texte", "category": "Test Categorie"]]
    
    static let resultAnecdote = [[ "id": "12", "category": "Science", "title": "Hello", "text": "le texte", "Date": Date()]]
    
    static let resultComment =  [["anecdoteId": "13", "commentText": "commentaire", "date": Date(), "userId": "dedededed", "userName": "bob"]]
    

}
