//
//  AnecdoteTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 15/12/2021.
//

import UIKit

class AnecdoteTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var pinkSeparator: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textTextfield: UITextView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    
    var anecdote: Anecdote? {
        didSet {
            guard let anecdote = anecdote else {
                return
            }
            dateLabel.text = anecdote.date
            categoryLabel.text = "\(anecdote.categorie.rawValue)"
            titleLabel.text = anecdote.title
            textTextfield.text = anecdote.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
        textTextfield.textContainerInset = UIEdgeInsets(top: 8, left: -2, bottom: 0, right: 0)
        commentButton.layer.cornerRadius = 15
        shareButton.layer.cornerRadius = 15
        
    }
    
    func setFade() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: textTextfield.frame.width, height: 130)
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.1, 0.6, 1]
        
        textTextfield.layer.mask = gradientMaskLayer
    }
    

}
