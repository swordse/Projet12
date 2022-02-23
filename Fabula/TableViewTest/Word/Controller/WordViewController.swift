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
        title = "Mot du jour"
        wordTableview.register(WordTableViewCell.nib(), forCellReuseIdentifier: WordTableViewCell.identifier)
        wordTableview.dataSource = datasource
        wordTableview.delegate = datasource
        wordViewModel?.getWords()
        bind()
    }
    
    func bind() {
        wordViewModel?.wordsToDisplay = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print(error)
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
    
}
