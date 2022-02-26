//
//  DetailAnecdoteTableViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 17/12/2021.
//

import UIKit


class DetailAnecdoteTableViewController: UITableViewController, StoryBoarded {
    
    // instance for the accountView (to allow user to connect)
    let userAccount = UserAccountController()
    // instance for the commentView (to allow user to add comment)
    let commentForm = CommentForm()
    
    var coordinator: AnecdoteCoordinator?
    var anecdote: Anecdote?
//    var comments: [Comment]?
    var detailAnecdoteViewModel: DetailAnecdoteViewModel?
    
    var datasource = DetailAnecdoteDataSource()
    var commentIsTapped = false
    var isFavoriteNavigation = false
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add notificationCenter observer to delete favorite
        NotificationCenter.default.addObserver(self, selector: #selector(deleteFavorite(notification:)), name: Notification.Name("deleteFavorite"), object: nil)
        
        // add notificationCenter observer to save favorite
        NotificationCenter.default.addObserver(self, selector: #selector(saveFavorite(notification:)), name: Notification.Name("saveFavorite"), object: nil)
        // set up view
        tableview.register(CommonAnecdoteTableViewCell.nib(), forCellReuseIdentifier: CommonAnecdoteTableViewCell.identifier)
        title = "Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        // set up data
        tableview.dataSource = datasource
        bind()
        
        guard let anecdote = anecdote else {
            return
        }
        // inform datasource about the user state
        datasource.updateIsConnected(isConnected: UserDefaultsManager().retrieveUserConnexion())
        
        detailAnecdoteViewModel?.getComments(id: anecdote.id)
        
        datasource.updateAnecdote(anecdote: anecdote)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let anecdote = anecdote else {
            return
        }
        detailAnecdoteViewModel?.getFavorite()
        detailAnecdoteViewModel?.isFavorite(anecdote: anecdote)
        tableview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if commentIsTapped {
            // scroll to the section to add comments
                tableview.scrollToRow(at: IndexPath(item: 0, section: 2), at: .top, animated: true)
        }
    }
    // bind with the viewmodel closures
    func bind() {
        // get comments
        detailAnecdoteViewModel?.comments = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let comments):
                    self?.datasource
                        .updateComments(comments: comments)
                    self?.tableview.reloadData()
                case.failure(let error):
                    switch error {
                    case.noData:
                        self?.alert(networkError: error)
                    case.errorOccured:
                        self?.alert(networkError: error)
                    case.noConnection:
                        self?.alert(networkError: error)
                    default:
                        print("Unrecognized error")
                    }
                }
            }
        }
        // check is anecdote is a favorite
        detailAnecdoteViewModel?.isFavorite = { [weak self] bool in
            if bool == true {
                self?.datasource.updateIsFavorite(isFavorite: true)
            } else {
                self?.datasource.updateIsFavorite(isFavorite: false)
            }
        }

        // connexionButtonIsTapped show connexion form
        datasource.commentConnexionButtonTapped = { [weak self] bool in
            if bool {
                guard let navigationController = self?.navigationController else {
                return
            }
                self?.userAccount.showUserConnexion(on: navigationController)
                self?.userAccount.authentificationDelegate = self
            }
        }
        // submitButtonIsTapped show comment form
        datasource.commentSubmitButtonTapped = { [weak self] bool in
            if bool {
            guard let navigationController = self?.navigationController else {
            return
        }
            self?.commentForm.showCommentForm(on: navigationController)
            self?.commentForm.submittedCommentDelegate = self
            }
        }
        // shareButton tapped
        datasource.textToShare = { [weak self] text in
                    let items: [Any] = ["J'ai trouvé cette anecdote sur l'application Fabula:", text]
                    
                    let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    
                    self?.present(shareController, animated: true, completion: nil)
                }
        // comment button tapped
        datasource.scrollToComment = { [weak self] bool in
            if bool {
                self?.tableview.scrollToRow(at: IndexPath(item: 0, section: 2), at: .top, animated: true)
            }
            }
        tableview.reloadData()
    }
    
    @objc
    func deleteFavorite(notification: Notification) {
        let userInfo = notification.userInfo
        guard let anecdote = userInfo?["anecdote"] as? Anecdote else {
            return
        }
        detailAnecdoteViewModel?.deleteFavorite(anecdote: anecdote)
        
        if isFavoriteNavigation {
            coordinator?.pop()
        }
    }
    
    @objc
    func saveFavorite(notification: Notification) {
        let userInfo = notification.userInfo
        guard let anecdote = userInfo?["anecdote"] as? Anecdote else {
            return
        }
        detailAnecdoteViewModel?.saveFavorite(anecdote: anecdote)
    }
    
    @objc
    func connexionTapped() {
        
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
        userAccount.authentificationDelegate = self
    }
    
}

extension DetailAnecdoteTableViewController: AuthentificationProtocol {
    func statusChange(isConnected: Bool) {
        if isConnected {
            datasource.updateIsConnected(isConnected: true)
            tableview.reloadData()
        } else {
            datasource.updateIsConnected(isConnected: false)
            tableview.reloadData()
        }
    }
}

extension DetailAnecdoteTableViewController: SubmittedCommentDelegate {
    func commentSubmitted(comment: String) {
        guard let anecdoteId = anecdote?.id else {
            return
        }
        detailAnecdoteViewModel?.save(comment: comment, anecdoteId: anecdoteId)
    }
    
    
}
