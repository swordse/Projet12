//
//  QuizzViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/12/2021.
//

import Foundation
import UIKit

final class HomeQuizzViewModel {
    
    var quizzService = QuizzService()
    var delegate: QuizzGetTest!
    
    init(quizzService: QuizzService = QuizzService(), delegate: QuizzGetTest) {
        self.quizzService = quizzService
        self.delegate = delegate
    }
    
    //MARK: - Output
    // categories contains data for the first row with image and category name
    var categories: (([QuizzCategoryInfo]) -> Void)?
    // theme contains name of each quizz by category
    var theme: ((Result<[[String]], NetworkError>) -> Void)?
    
    var quizzs = [Quizz]()
    
    // retrieve category for HomeQuizz
    func retrieveCategory() {
        var categoriesName = [String]()
        var themeName = [[String]]()
        quizzService.getCategoryQuizz { [weak self] result in
            switch result {
            case.failure(let error):
                self?.theme?(.failure(error))
            case.success(let success):
                for i in 0 ..< success.count {
                    for (key, value) in success[i] {
                        categoriesName.append(key)
                        themeName.append(value as! [String])
                    }
                }
                self?.getCategoryInfo(category: categoriesName)
                self?.theme?(.success(themeName))
            }
        }
    }
    
    // based on category name, create a QuizzCategoryInfo to have requested info to display
    func getCategoryInfo(category: [String]) {
        var quizzCategoryInfo: QuizzCategoryInfo?
        var quizzCategoryInfos = [QuizzCategoryInfo]()
        for item in category {
            let quizzCategory = QuizzCategory(rawValue: item)
            switch quizzCategory {
            case.histoire:
                quizzCategoryInfo = QuizzCategoryInfo(name: item, image: UIImage(named: "Histoire")!, color: UIColor(named: "green")!)
            case.science:
                quizzCategoryInfo = QuizzCategoryInfo(name: item, image: UIImage(named: "Science")!, color: UIColor(named: "blue")!)
            case.litterature:
                quizzCategoryInfo = QuizzCategoryInfo(name: item, image: UIImage(named: "Littérature")!, color: UIColor(named: "purple")!)
            case.art:
                quizzCategoryInfo = QuizzCategoryInfo(name: item, image: UIImage(named: "Art")!, color: UIColor(named: "pink")!)
                
            case .none:
                print("no category")
            }
            guard let quizzCategoryInfo = quizzCategoryInfo else { return }
            quizzCategoryInfos.append(quizzCategoryInfo)
        }
        categories?(quizzCategoryInfos)
    }
    
    // retrieve theme for TestQuizz
    func retrieveQuizz(theme: String) {
        
        quizzService.getQuizzs(title: theme) { [weak self] result in
            switch result {
            case.failure(let error):
                print("ERROR \(error)")
            case.success(let success):
                var quizzs = [Quizz]()
                for element in success {
                    let quizz = Quizz(category: element["category"] as! String, propositions: element["propositions"] as! [String], question: element["question"] as! String, response: element["response"] as! String, title: element["title"] as! String)
                    quizzs.append(quizz)
                }
                self?.quizzs = quizzs
                self?.delegate.getTest(quizzs: quizzs)
            }
        }
    }
    
    func selectedTheme(theme: String) {
        retrieveQuizz(theme: theme)
    }
    
}
