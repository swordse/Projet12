//
//  Quizz.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import Foundation
import UIKit
// struct for the Quizzs with questions and propositions
struct Quizz {
    var category: String
    var propositions: [String]
    var question: String
    var response: String
    var title: String
}
// enum to keep track of the available category
enum QuizzCategory: String {
    case histoire = "Histoire"
    case science = "Science"
    case litterature = "Littérature"
    case art = "Art"
}
// struct to associate display info to category
struct QuizzCategoryInfo {
    var name: String
    var image: UIImage
    var color: UIColor
}


