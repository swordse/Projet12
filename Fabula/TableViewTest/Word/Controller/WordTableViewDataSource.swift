//
//  WordTableViewDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation
import UIKit

class WordTableViewDataSource: NSObject, UITableViewDataSource {
    
    var words = [Word]()
    
    var endReached: ((Bool) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        let word = words[indexPath.row]
        cell.word = word
        return cell
        
    }
    
}

extension WordTableViewDataSource:  UITableViewDelegate {
    // keep track of the tableview end to reload new anecdotes
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == words.count {
            endReached?(true)
            print("end reached in datasource")
        }
    }
}
