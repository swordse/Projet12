//
//  SourceTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 10/01/2022.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var sourceButton: UIButton!
    
    var source: String? {
        didSet {
            guard let source = source else {
                return
            }
//            sourceButton.titleLabel?.text = source
            sourceButton.setTitle(source, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sourceButtonTapped(_ sender: Any) {
        guard let stringUrl = sourceButton.titleLabel?.text else { return }
        guard let url = URL(string: stringUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
