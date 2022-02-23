//
//  WordTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import UIKit

final class WordTableViewCell: UITableViewCell {

    static let identifier = "WordTableViewCell"
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var qualifierLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    var word: Word? {
        didSet {
            guard let word = word else {
                return
            }
            wordLabel.text = word.word.uppercased()
            qualifierLabel.text = word.qualifier
            definitionLabel.text = word.definition
            exampleLabel.text = "\"\(word.example)\""
        }
    }
    
    static func nib() -> UINib? {
        return UINib(nibName: "WordTableViewCell", bundle: nil)
    }
    
}
