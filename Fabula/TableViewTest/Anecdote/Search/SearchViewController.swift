//
//  SearchViewController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 18/01/2022.
//

import UIKit

class SearchViewController: UIViewController, StoryBoarded, UISearchBarDelegate {
    
    var coordinator: AnecdoteCoordinator?
    var searchViewModel: SearchViewModel?
    var datasource = SearchDataSource()
    
    let searchController = UISearchController()
    
    var anecdotes = [Anecdote]()
    var resultAnecdotes = [Anecdote]()
    
    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        title = "Recherche"
        view.backgroundColor = .deepBlue
        
        resultTableView.dataSource = datasource
        resultTableView.delegate = datasource
        
        bind()
        
        searchViewModel?.getAnecdotes()
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
//        searchInAnecdote(words: words)
//        print("RESULT ANECDOTES: \(resultAnecdotes)")
//        datasource.updateItems(items: resultAnecdotes)
//        resultTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        datasource.updateItems(items: [Anecdote]())
        resultTableView.reloadData()
    }
    
    
    func bind() {
        searchViewModel?.fetchAnecdotes = {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let anecdotes):
                    self?.anecdotes = anecdotes
                case.failure(_):
                    print("Erreur lors de la recherche")
//                    CustomAlert().showAlert(with: "Malheureusement une erreur est survenue.", message: "Veuillez vérifier votre connexion à internet.", on: self!)
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
//        var result = [Anecdote]()
//
//        for anecdote in anecdotes {
//            for word in words {
//                if anecdote.text.lowercased().contains(word.lowercased()) {
//                    if !result.contains(where: { result in
//                        result.id == anecdote.id
//                    }) {
//                    result.append(anecdote)
//                    }
//                }
//            }
//
//        }
//        resultAnecdotes = result
    }
    
    
}
