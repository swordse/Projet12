//
//  FavoriteDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 12/01/2022.
//

import Foundation
import UIKit

class FavoriteDataSource: NSObject {
    
    var anecdotes = [Anecdote]()
    
    func updateAnecdotes(anecdotes: [Anecdote]) {
        self.anecdotes = anecdotes
    }
    // pass anecdote, check if is favorite, check if is comment button tapped
    var selectedRow: ((Anecdote, Bool, Bool) -> Void)?
    
    var textToShare: ((String) -> Void)?
}

extension FavoriteDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if anecdotes.count == 0 {
            return 0
        } else {
        return anecdotes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if anecdotes.count > 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonAnecdoteTableViewCell.identifier) as? CommonAnecdoteTableViewCell else { return UITableViewCell() }
//            cell.textLabel?.text = "Vous n'avez pas encore de favoris. \nPour en ajouter, cliquez sur le coeur se trouvant sous chaque anecdote"
//            return cell
//        } else {
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = """
Vous n'avez pas de favoris.
Pour en ajouter, cliquez sur le coeur
dans le détail d'une anecdote.
"""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return anecdotes.isEmpty ? 200 : 0
        
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
