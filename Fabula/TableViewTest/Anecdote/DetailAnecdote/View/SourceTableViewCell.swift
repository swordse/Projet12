//
//  SourceTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 10/01/2022.
//

import UIKit
// cell for the source of the anecdote
class SourceTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var sourceButton: UIButton!
    
    var source: String? {
        didSet {
            guard let source = source else {
                return
            }
            sourceButton.setTitle(source, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }

    @IBAction func sourceButtonTapped(_ sender: Any) {
        guard let stringUrl = sourceButton.titleLabel?.text else { return }
        guard let url = URL(string: stringUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
