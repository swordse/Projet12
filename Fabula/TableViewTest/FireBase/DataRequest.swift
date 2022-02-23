//
//  DataRequest.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 11/02/2022.
//

import Foundation
/// enum to get the string to perform the FireBase request
enum DataRequest: String {
    case anecdotes = "anecdotes"
    case comments = "comments"
    case words = "words"
    case citations = "citations"
    case user = "users"
    case categoryQuizz = "categoryQuizz"
    case quizzs = "quizzs"
}
