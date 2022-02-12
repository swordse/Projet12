//
//  QuoteTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/02/2022.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    static let identifier = "QuoteTableViewCell"
    
    @IBOutlet weak var quoteCategory: UILabel!
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var quote: Quote? {
        didSet {
            guard let quote = quote else {
                return
            }
            quoteTextLabel.text = quote.text
            authorLabel.text = quote.authorName
            quoteCategory.text = quote.category
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareButton.setTitle("", for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let quoteToShare = Notification.Name("quoteToShare")
        NotificationCenter.default.post(name: quoteToShare, object: nil, userInfo: ["quote": quote?.text as Any])
        
    }
    
    static func nib() -> UINib? {
        return UINib(nibName: "QuoteTableViewCell", bundle: nil)
    }
    
}
