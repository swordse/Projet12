//
//  ViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 14/12/2021.
//

import UIKit

class AnecdoteViewController: UIViewController, StoryBoarded {
    
    let userAccount = UserAccount()
    
    var coordinator: AnecdoteCoordinator?
    var anecdoteViewModel: AnecdoteViewModel?
    var dataSource = AnecdoteListDataSource()
    
    var anecdoteTextToShare = ""
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    // variable to add a badge to the favoriteButton
    private var hub: BadgeHub?
    
    var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("Vos favoris", for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.setShadow()
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setTitle("Recherche", for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.setShadow()
        
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // set header for tableview
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        headerView.backgroundColor = .deepBlue
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(favoriteButton)
        headerView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(greaterThanOrEqualTo: searchButton.leadingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            favoriteButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            searchButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            searchButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            searchButton.widthAnchor.constraint(equalTo: favoriteButton.widthAnchor)
        ])
        
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // - MARK: Set up view
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        title = "Anecdotes"
        view.backgroundColor = .deepBlue
        tableView.register(CommonAnecdoteTableViewCell.nib(), forCellReuseIdentifier: CommonAnecdoteTableViewCell.identifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(connexionTapped))
        
        // set the Badge on favoriteButton
        setupBadgeOnView()
        
        // - MARK: Set up data/ delegate
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        // - MARK: Bind
        bind()
        anecdoteViewModel?.getAnecdotes()
        anecdoteViewModel?.getFavNumber()
    }
    
    func setupBadgeOnView() {
        hub = BadgeHub(view: favoriteButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // getFavNumber is call in viewDidLoad to update the data
        anecdoteViewModel?.getFavNumber()
        tableView.reloadData()
    }
    
    func bind() {
        // anecdotes to display
        
        anecdoteViewModel?.anecdotesToDisplay = {
            [weak self] anecdotes in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            DispatchQueue.main.async {
                switch anecdotes {
                case.failure(let error):
                    switch error {
                    case.noData:
                        print("no data")
                        self?.alert()
                    case.errorOccured:
                        print("alert errorOccured")
                        self?.alert()
                    case.noConnection:
                        print("alert noConnexion")
                        self?.alert()
                    }
                    print("ERROR WHEN FETCH ANECDOTES")
                    //                    self?.alert()
                case.success(let anecdotes):
                    self?.dataSource.updateItems(items: anecdotes)
                    print("ANECDOTES TO DISPLAY COUNT: \(anecdotes.count)")
                    print("ANECDOTETODISPLAY RESULT: \(anecdotes)")
                    self?.tableView.reloadData()
                }
            }
        }
        
        // number of favorites
        anecdoteViewModel?.numberOfFavorites = {
            number in
            BadgedButtonItem.shared.setBadge(with: number)
            print("Closure dans AnecdoteVC s'exècute avec number: \(number)")
            self.hub?.setCount(number)
        }
        // dataSource inform that a row is selected, we can pass to coordinator (anecdote, is favorite, iscomment)
        dataSource.selectedRow = coordinator?.showDetail(anecdote:commentIsTapped:isFavoriteNavigation:)
        
        // UIActivityController when dataSource indicate a text to share
        dataSource.textToShare = {
            [weak self] text in
            
            let items: [Any] = ["J'ai trouvé cette anecdote sur l'application Fabula:", text ]
            
            let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self?.present(activity, animated: true, completion: nil)
        }
        
        // if the tableview end is reached, fetch new anecdotes
        dataSource.endReached = { [weak self]
            bool in
            print("end reached in viewcontroller")
            if bool {
                self?.anecdoteViewModel?.getNewAnecdotes()
            }
        }
    }
    
    @objc func favoriteButtonTapped() {
        coordinator?.showFavorite()
    }
    
    @objc func searchButtonTapped() {
        coordinator?.showSearch()
    }
    
    @objc func connexionTapped() {
        guard let navigationController = navigationController else {
            return
        }
        userAccount.showUserConnexion(on: navigationController)
    }
    
    
}




