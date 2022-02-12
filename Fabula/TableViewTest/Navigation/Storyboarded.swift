//
//  Storyboarded.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 17/12/2021.
//

import Foundation
import UIKit

protocol StoryBoarded {
    
    static func instantiate() -> Self
}

extension StoryBoarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    
    }
}
// protocol to show delegate, with anecdote. Permit to check if we are in favoriteNavigation and if comment button was tapped
protocol AnecdoteDetailDelegate {
    func getDetail (anecdote: Anecdote, commentIsTapped: Bool, isFavoriteNavigation: Bool)
}

protocol ShowFavoriteDelegate {
    func showFavoriteDelegate()
}

protocol QuizzGetTest {
    func getTest (quizzs: [Quizz])
}
