//
//  DetailAnecdoteTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/01/2022.
//

import UIKit

class DetailAnecdoteTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textTextfield: UITextView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var backDetailView: UIView!
    

    
//    var anecdote: Anecdote? {
//        didSet {
//            guard let anecdote = anecdote else {
//                return
//            }
//
//            categoryLabel.text = anecdote.categorie.rawValue
//            titleLabel.text = anecdote.title
//            textTextfield.text = anecdote.text
//            backDetailView.layer.cornerRadius = 15
//            if anecdote.isFavorite {
//                favoriteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .small), forImageIn: .normal)
//                favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
//            } else {
//                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
//                favoriteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .small), forImageIn: .normal)
//            }
//
//        }
//    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(anecdote: Anecdote, isFavorite: Bool) {
        
        categoryLabel.text = anecdote.categorie.rawValue
        titleLabel.text = anecdote.title
        textTextfield.text = anecdote.text
        backDetailView.layer.cornerRadius = 15
        favoriteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
