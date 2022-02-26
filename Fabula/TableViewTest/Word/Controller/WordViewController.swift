//
//  WordViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import UIKit

final class WordViewController: UIViewController, StoryBoarded {
    
    var coordinator: WordCoordinator?
    var wordViewModel: WordViewModel?
    var datasource = WordTableViewDataSource()
    var delegate = WordTableViewDataSource()
    var words = [Word]()
    
    @IBOutlet weak var wordTableview: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wordTableview.register(WordTableViewCell.nib(), forCellReuseIdentifier: WordTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up view
        title = "Mot du jour"
        wordTableview.register(WordTableViewCell.nib(), forCellReuseIdentifier: WordTableViewCell.identifier)
        // set up data
        wordTableview.dataSource = datasource
        wordTableview.delegate = datasource
        // add notification observer to observe word shared
        NotificationCenter.default.addObserver(self, selector: #selector(wordQuote(notification:)), name: Notification.Name("wordToShare"), object: nil)
        
        wordViewModel?.getWords()
        bind()
    }
    // bind with viewModel closures
    func bind() {
        wordViewModel?.wordsToDisplay = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    self?.alert(networkError: error)
                case.success(let success):
                    self?.words = success
                    self?.datasource.words = success
                    self?.wordTableview.reloadData()
                }
            }
        }
        
        datasource.endReached = {
            [weak self] _ in
            self?.wordViewModel?.getNewWords()
        }
    }
    
    @objc func wordQuote(notification: Notification) {
        let userInfo = notification.userInfo
        let wordToShare = userInfo?["word"]
        let definitionToShare = userInfo?["definition"]
        let items: [Any] = ["J'ai trouvé cette définition sur l'application Fabula", wordToShare as Any, definitionToShare as Any]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: [])
        present(activityController, animated: true, completion: nil)
    }
    
}
