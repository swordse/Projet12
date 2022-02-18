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
    
    var selectedRow: ((Anecdote, Bool, Bool) -> Void)?
    
    var endReached : ((Bool) -> Void)?
 
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
        cell.shareDelegate = self
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
        print("INDEXPATH SELECTED: \(indexPath)")
    }
    
    // keep track of the tableview end to reload new anecdotes
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == items.count {
            endReached?(true)
            print("end reached in datasource")
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
