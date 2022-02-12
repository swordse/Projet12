//
//  QuoteViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import UIKit

class QuoteViewController: UIViewController, StoryBoarded {

    var quoteViewModel: QuoteViewModel?
    var coordinator: QuoteCoordinator?
    var quotes = [Quote]()
    let datasource = QuoteTableViewDataSource()
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Citation"
//        tabBarController?.tabBar.backgroundColor = UIColor.deepBlue
//        tabBarController?.tabBar.tintColor = UIColor.deepBlue
//        let appearance = UITabBarAppearance()
//        appearance.backgroundColor = UIColor.deepBlue
//        appearance.configureWithTransparentBackground()
//        tabBarController?.tabBar.standardAppearance = appearance
        
        quoteTableView.register(QuoteTableViewCell.nib(), forCellReuseIdentifier: QuoteTableViewCell.identifier)
        quoteTableView.separatorColor = .purple
        quoteTableView.dataSource = datasource
        quoteTableView.delegate = datasource
        bind()
        quoteViewModel?.getQuotes()
        
        // add notificationCenter to observe the quoteShare
        NotificationCenter.default.addObserver(self, selector: #selector(shareQuote(notification:)), name: Notification.Name("quoteToShare"), object: nil)
    }
    
    
    func bind() {
        quoteViewModel?.quotesToDisplay = { [weak self] result in
            DispatchQueue.main.async {
                
            switch result {
            case.success(let quotes):
                self?.quotes = quotes
                self?.datasource.quotes = quotes
                print("dans QuoteVC quotes: \(self?.quotes)")
                self?.quoteTableView.reloadData()
            case.failure(let error):
                switch error {
                case.noData:
                    print("no data")
                case.errorOccured:
                    print("error occured")
                case.noConnection:
                    print("no connection")
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
    
    @objc func shareQuote(notification: Notification) {
        let userInfo = notification.userInfo
        let textToShare = userInfo?["quote"]
        let items: [Any] = ["J'ai trouvé cette citation sur l'application Fabula", textToShare]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: [])
        present(activityController, animated: true, completion: nil)
    }
}
