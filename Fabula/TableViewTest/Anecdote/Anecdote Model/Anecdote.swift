//
//  Anecdote.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 15/12/2021.
//

import Foundation

// struct for the anecdotes
struct Anecdote {
    var id: String
    var categorie: Category
    var title: String
    var text: String
    var source: String?
    var date: String
    var isFavorite: Bool
}
// categories of the anecdotes
enum Category: String {
    case litterature = "Littérature"
    case science = "Science"
    case histoire = "Histoire"
    case arts = "Art"
    case geographie = "Géographie"
    case insolite = "Insolite"
    case picture = "Picture"
}
