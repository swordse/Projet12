//
//  SearchDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 18/01/2022.
//

import Foundation
import UIKit

final class SearchDataSource: NSObject {
    
    private var items = [Anecdote]()

    func updateItems(items: [Anecdote]) {
        self.items = items
    }
    
    var selectedRow: ((Int) -> Void)?
 
}

extension SearchDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AnecdoteTableViewCell else {
            return UITableViewCell()
        }
        let anecdote = items[indexPath.row]
        cell.anecdote = anecdote
        cell.setFade()
        
        return cell
    }
    
}

extension SearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow?(indexPath.row)
    }
    
    
}
