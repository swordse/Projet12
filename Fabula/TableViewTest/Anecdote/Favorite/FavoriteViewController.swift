//
//  FavoriteViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import UIKit

class FavoriteViewController: UIViewController, StoryBoarded {
    
    let userAccount = UserAccount()
    
    var coordinator: AnecdoteCoordinator?
    var favoriteViewModel: FavoriteViewModel?
    var dataSource = FavoriteDataSource()
    
    var favoriteAnecdote = [Anecdote]()
    var textToShare = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoris"
        tableView.register(CommonAnecdoteTableViewCell.nib(), forCellReuseIdentifier: CommonAnecdoteTableViewCell.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        bind()
        favoriteViewModel?.getFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        favoriteViewModel?.getFavorite()
        tableView.reloadData()
    }
    
    func bind() {
        // favorites retrieve from coredata
        favoriteViewModel?.favoriteAnecdote = { [weak self ] anecdotes in
            self?.dataSource.updateAnecdotes(anecdotes: anecdotes)
            print("FAVORITE ANECDOTES RECUPEREES DE COREDATA \(anecdotes)")
            self?.dataSource.selectedRow = self?.favoriteViewModel?.selectedRow
        }
        
        // UIActivityController when dataSource indicate a text to share
        dataSource.textToShare = {
            [weak self] text in
            let items: [Any] = ["J'ai trouvé cette anecdote sur l'application Fabula:", text ]
            
            let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self?.present(activity, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
//        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
//        guard let indexPath = tableView.indexPathForRow(at: buttonPosition)  else { return }
//
//        favoriteViewModel?.selectedRow(int: indexPath.row, commentIsTapped: true, isFavoriteNavigation: true)
       
    }
    
    @IBAction func sharedButtonTapped(_ sender: Any) {
//        let items: [Any] = ["J'ai trouvé cette anecdote sur l'application Fabula:", textToShare ]
//
//        let sharedController = UIActivityViewController(activityItems: items, applicationActivities: nil)
//
//        present(sharedController, animated: true, completion: nil)
    }
    
    @objc func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
    }
}
