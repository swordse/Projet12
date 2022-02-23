//
//  SearchViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 18/01/2022.
//

import UIKit
// SearchController to search anecdote among anecdotes
final class SearchViewController: UIViewController, StoryBoarded, UISearchBarDelegate {
    
    var coordinator: AnecdoteCoordinator?
    var searchViewModel: SearchViewModel?
    var datasource = SearchDataSource()
    
    let searchController = UISearchController()
    // array of all anecdotes
    var anecdotes = [Anecdote]()
    // array of the search result anecdotes
    var resultAnecdotes = [Anecdote]()
    
    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.register(CommonAnecdoteTableViewCell.nib(), forCellReuseIdentifier: CommonAnecdoteTableViewCell.identifier)
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        title = "Recherche"
        view.backgroundColor = .deepBlue
        
        resultTableView.dataSource = datasource
        resultTableView.delegate = datasource
        
        bind()
        searchViewModel?.getAllAnecdotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        let words = text.components(separatedBy: " ")
        searchViewModel?.searchInAnecdote(words: words)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        datasource.updateItems(items: [Anecdote]())
        resultTableView.reloadData()
    }
    
    func bind() {
        searchViewModel?.allAnecdotes = {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(_):
                    print("all anecdotes fetched")
                case.failure(let error):
                    print("Erreur lors de la recherche")
                    self?.alert(networkError: error)
                }
            }
        }
        
        searchViewModel?.resultAnecdotes =  {
            [weak self] result in
            self?.datasource.updateItems(items: result)
            self?.resultTableView.reloadData()
        }

        datasource.selectedRow = searchViewModel?.selectedRow
    }
    
    func searchInAnecdote(words: [String]) {
        searchViewModel?.searchInAnecdote(words: words)
    }
    
}
