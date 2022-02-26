//
//  AnecdotesListDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 15/12/2021.
//

import Foundation
import UIKit

final class AnecdoteListDataSource: NSObject {
    
    private var items = [Anecdote]()
    
    func updateItems(items: [Anecdote]) {
        self.items = items
    }
    // closure to provide the selected row
    var selectedRow: ((Anecdote, Bool, Bool) -> Void)?
    // closure to inform that end is reached
    var endReached : ((Bool) -> Void)?
    // closure to provide the text to share in UIActivityController
    var textToShare: ((String) -> Void)?
}

extension AnecdoteListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonAnecdoteTableViewCell.identifier, for: indexPath) as? CommonAnecdoteTableViewCell else {
            return UITableViewCell()
        }
        // dataSource is delegate of the cell if share button is tapped
        cell.shareDelegate = self
        // dataSource is delegate of the cell if comment button is tapped
        cell.commentDelegate = self
        
        let anecdote = items[indexPath.row]
        cell.setCell(anecdote: anecdote,
                     isFavorite: false,
                     isDetail: false,
                     dateIsHidden: false,
                     heartIsHidden: true,
                     chevronIsHidden: false)
        cell.setFade()
        return cell
    }
}

extension AnecdoteListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let anecdote = items[indexPath.row]
        
        selectedRow?(anecdote, false, false)
    }
    
    // keep track of the tableview end to reload new anecdotes
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == items.count {
            endReached?(true)
        }
    }
}

extension AnecdoteListDataSource: ShareDelegate {
    func shareTapped(with textToShare: String) {
        self.textToShare?(textToShare)
    }
}

extension AnecdoteListDataSource: CommentDelegate {
    func commentWasTapped(for anecdote: Anecdote) {
        selectedRow?(anecdote, true, false)
    }
    
}
