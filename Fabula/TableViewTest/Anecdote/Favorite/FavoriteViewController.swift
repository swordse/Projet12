//
//  FavoriteViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import UIKit

// controller to display the favorites saved by user
final class FavoriteViewController: UIViewController, StoryBoarded {
    
    let userAccount = UserAccountController()
    var coordinator: AnecdoteCoordinator?
    var favoriteViewModel: FavoriteViewModel?
    var dataSource = FavoriteDataSource()
    var anecdotes = [Anecdote]()
    
    private var favoriteAnecdote = [Anecdote]()
    private var textToShare = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoris"
//        navigationItem.largeTitleDisplayMode = .always
        tableView.register(CommonAnecdoteTableViewCell.nib(), forCellReuseIdentifier: CommonAnecdoteTableViewCell.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        bind()
        
//        favoriteViewModel?.getFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteViewModel?.getFavorite()
//        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if anecdotes.isEmpty {
            self.emptyFavoriteAlert()
        }
    }
    
    private func bind() {
        // favorites retrieve from coredata
        favoriteViewModel?.favoriteAnecdote = { [weak self ] anecdotes in
            DispatchQueue.main.async {
            
                self?.dataSource.updateAnecdotes(anecdotes: anecdotes)
                self?.anecdotes = anecdotes
                self?.dataSource.selectedRow = self?.favoriteViewModel?.selectedRow
            self?.tableView.reloadData()
            }
            
        }
        
        // UIActivityController when dataSource indicate a text to share
        dataSource.textToShare = {
            [weak self] text in
            let items: [Any] = ["J'ai trouvé cette anecdote sur l'application Fabula:", text ]
            
            let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self?.present(activity, animated: true, completion: nil)
        }
    }

    @objc func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
    }
}
