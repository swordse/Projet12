//
//  QuoteViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import UIKit

final class QuoteViewController: UIViewController, StoryBoarded {
    
    var quoteViewModel: QuoteViewModel?
    var coordinator: QuoteCoordinator?
    var quotes = [Quote]()
    let datasource = QuoteTableViewDataSource()
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up view
        title = "Citations"
        quoteTableView.register(QuoteTableViewCell.nib(), forCellReuseIdentifier: QuoteTableViewCell.identifier)
        quoteTableView.separatorColor = .purple
        // set up data
        quoteTableView.dataSource = datasource
        quoteTableView.delegate = datasource
        bind()
        quoteViewModel?.getQuotes()
        // add notificationCenter to observe the quoteShare
        NotificationCenter.default.addObserver(self, selector: #selector(shareQuote(notification:)), name: Notification.Name("quoteToShare"), object: nil)
    }
    // bind with viewmodel closures
    func bind() {
        quoteViewModel?.quotesToDisplay = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let quotes):
                    self?.quotes = quotes
                    self?.datasource.quotes = quotes
                    self?.quoteTableView.reloadData()
                case.failure(let error):
                    switch error {
                    case.noData:
                        self?.alert(networkError: .noData)
                    case.errorOccured:
                        self?.alert(networkError: .errorOccured)
                    case.noConnection:
                        self?.alert(networkError: .noConnection)
                    default:
                        self?.alert(networkError: .errorOccured)
                    }
                }
            }
        }
        datasource.endReached = { [weak self] bool in
            if bool {
                self?.quoteViewModel?.getNewQuotes()
            }
        }
    }
    // display activityController when shareButton is tapped
    @objc func shareQuote(notification: Notification) {
        let userInfo = notification.userInfo
        let textToShare = userInfo?["quote"]
        let items: [Any] = ["J'ai trouvé cette citation sur l'application Fabula", textToShare as Any]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: [])
        present(activityController, animated: true, completion: nil)
    }
}
