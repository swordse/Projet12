//
//  WordTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/02/2022.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    static let identifier = "WordTableViewCell"
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var definitionLabel: UILabel!
    
    
    var word: Word? {
        didSet {
            guard let word = word else {
                return
            }
            wordLabel.text = word.word.uppercased()
            definitionLabel.text = word.definition
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib? {
        return UINib(nibName: "WordTableViewCell", bundle: nil)
    }
    
}
