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
    // closure to transmit the cell tapped
    var selectedRow: ((Int) -> Void)?
}

extension SearchDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonAnecdoteTableViewCell.identifier, for: indexPath) as? CommonAnecdoteTableViewCell else {
            return UITableViewCell()
        }
        let anecdote = items[indexPath.row]
        cell.setCell(anecdote: anecdote, isFavorite: false, isDetail: false, dateIsHidden: false, heartIsHidden: true, chevronIsHidden: false)
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
