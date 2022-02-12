//
//  QuoteTableViewDataSource.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import Foundation
import UIKit


class QuoteTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var quotes = [Quote]()
    
    var endReached: ((Bool) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dans quoteDataSource: \(quotes)")
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier, for: indexPath) as? QuoteTableViewCell else {
            return UITableViewCell()
        }
        let quote = quotes[indexPath.row]
        cell.quote = quote
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == quotes.count {
            endReached?(true)
        }
    }
    
  
    
    
}
