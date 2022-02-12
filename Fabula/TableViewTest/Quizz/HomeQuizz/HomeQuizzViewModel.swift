//
//  QuizzViewModel.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 28/12/2021.
//

import Foundation
import UIKit

class HomeQuizzViewModel {
    
    var network = NetworkQuizz()
    var delegate: QuizzGetTest!
    
    //MARK: - Output
    var categories: (([QuizzCategoryInfo]) -> Void)?
    var theme: ((Result<[[String]], NetworkError>) -> Void)?
    
    
    init(delegate: QuizzGetTest) {
        self.delegate = delegate
    }
    var quizzs: (([Quizz]) -> Void)?
    
    // retrieve category for HomeQuizz
    func retrieveCategory() {
        var categoriesName = [String]()
        var themeName = [[String]]()
        network.getCategory { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print(error)
                    self?.theme?(.failure(error))
                case.success(let success):
                    for i in 0 ..< success.count {
                        for (key, value) in success[i] {
                            categoriesName.append(key)
                            themeName.append(value as! [String])
                            print("VALUE \(value)")
                        }
                    }
                    self?.getCategoryInfo(category: categoriesName)
//                    self?.categories!(categoriesName)
                    self?.theme?(.success(themeName))
                }
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
            guard let quizzCategoryInfo = quizzCategoryInfo else {
                return
            }
            quizzCategoryInfos.append(quizzCategoryInfo)
        }
        categories?(quizzCategoryInfos)
    }
    
    // retrieve theme for TestQuizz
    func retrieveQuizz(theme: String) {
        network.getQuizz(title: theme) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print(error)
                case.success(let success):
                    var quizzs = [Quizz]()
                    print(success)
                    for i in 0 ..< success.count {
                        let quizz = Quizz(category: success[i].data()["category"] as! String, propositions: success[i].data()["propositions"] as! [String], question: success[i].data()["question"] as! String, response: success[i].data()["response"] as! String, title: success[i].data()["title"] as! String)
                        quizzs.append(quizz)
                    }
                    self?.delegate.getTest(quizzs: quizzs)
                    print("RETRIEVE QUIZZS \(quizzs)")
                }
            }
        }
    }
    
    func selectedTheme(theme: String) {
        retrieveQuizz(theme: theme)
    }
    
}
