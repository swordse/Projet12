//
//  FavoriteDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import Foundation
import UIKit

final class FavoriteDataSource: NSObject {
    
    var anecdotes = [Anecdote]()
    
    func updateAnecdotes(anecdotes: [Anecdote]) {
        self.anecdotes = anecdotes
    }
    // pass anecdote, check if is favorite, check if is comment button tapped
    var selectedRow: ((Anecdote, Bool, Bool) -> Void)?
    // if sharebutton tapped, transmit anecdote text
    var textToShare: ((String) -> Void)?
}

extension FavoriteDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anecdotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonAnecdoteTableViewCell.identifier) as? CommonAnecdoteTableViewCell else { return UITableViewCell() }
        
        let anecdote = anecdotes[indexPath.row]
        cell.setCell(anecdote: anecdote,
                     isFavorite: false,
                     isDetail: false,
                     dateIsHidden: false,
                     heartIsHidden: true,
                     chevronIsHidden: false)
        
        cell.shareDelegate = self
        cell.commentDelegate = self
        return cell
    }

}

extension FavoriteDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anecdote = anecdotes[indexPath.row]
        selectedRow?(anecdote, false, true)
    }
    
}

extension FavoriteDataSource: ShareDelegate {
    func shareTapped(with textToShare: String){
        self.textToShare?(textToShare)
    }
}

extension FavoriteDataSource: CommentDelegate {
    func commentWasTapped(for anecdote: Anecdote) {
        selectedRow?(anecdote, true, true)
    }
    
}
