//
//  FakeResponseData.swift
//  TableViewTestTests
//
//  Created by Raphaël Goupille on 11/02/2022.
//

import Foundation
@testable import TableViewTest

final class FakeResponseData {
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static let resultWord = [["definition": "ce qui définit" as Any, "word": "DEFINITION" as Any]]
    
    static let resultQuote = [["author": "bob", "text": "le texte", "category": "Test Categorie"]]
    
    
    
}


