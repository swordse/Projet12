//
//  CommonAnecdoteTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 01/02/2022.
//

import UIKit

/// Protocol of CommonAnecdoteTableViewCell to inform the requested controller (DetailController, FavoriteController) that shareButton is tapped in cell. The delegate (controller) use the textToShare to display a UIActivityController.
protocol ShareDelegate {
    func shareTapped(with textToShare: String)
}

/// Protocol of CommonAnecdoteTableViewCell to inform the requested dataSource (DetailDataSource, FavoriteDataSource) that commentButton is tapped in cell.
/// AnecdoteDataSource and FavoriteDelegate use it to pass bool "commentIsTapped" and "isFavoriteNavigation" to the controller which can call the coordinator to show the DetailController.
/// DetailController uses it to scroll to the comment section. 
protocol CommentDelegate {
    func commentWasTapped(for anecdote : Anecdote)
}
                                    

class CommonAnecdoteTableViewCell: UITableViewCell {
    
    var anecdote: Anecdote?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var anecdoteTextview: UITextView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var chevronImage: UIImageView!
    
    var shareDelegate: ShareDelegate?
    var commentDelegate: CommentDelegate?
    
    static let identifier = "CommonAnecdoteTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CommonAnecdoteTableViewCell", bundle: nil)
    }
    
    func getReturnString(text: String) -> String {
        return text.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    func setCell(anecdote: Anecdote, isFavorite: Bool, isDetail: Bool, dateIsHidden: Bool, heartIsHidden: Bool, chevronIsHidden: Bool) {
        self.anecdote = anecdote
        
        dateLabel.isHidden = dateIsHidden
        heartButton.isHidden = heartIsHidden
        chevronImage.isHidden = chevronIsHidden
    
        dateLabel.text = anecdote.date
        categoryLabel.text = anecdote.categorie.rawValue
        titleLabel.text = anecdote.title
        anecdoteTextview.text = getReturnString(text: anecdote.text)
        
        if isFavorite {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if isDetail {
            anecdoteTextview.heightAnchor.constraint(equalToConstant: 130).isActive = false
        } else {
            anecdoteTextview.heightAnchor.constraint(equalToConstant: 130).isActive = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        anecdoteTextview.textContainerInset = UIEdgeInsets(top: 8, left: -2, bottom: 0, right: 0)
        anecdoteTextview.textColor = .label
        commentButton.setTitle("", for: .normal)
        shareButton.setTitle("", for: .normal)
        
        titleLabel.textColor = .label
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFade() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: anecdoteTextview.frame.width, height: 130)
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.1, 0.6, 1]
        
        anecdoteTextview.layer.mask = gradientMaskLayer
    }
    
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        print("COMMENT BUTTON TAPPED")
        guard let anecdote = anecdote else {
            return
        }
        commentDelegate?.commentWasTapped(for: anecdote)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let text = anecdote?.text else {
            return
        }
        print(text)
        shareDelegate?.shareTapped(with: text)
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        
        // create notification to delete favorite
        let deleteFavorite = Notification.Name("deleteFavorite")

        // create notification to save favorite
        let saveFavorite = Notification.Name("saveFavorite")
        
        guard let anecdote = anecdote else {
            return
        }
        // check if it's already a favorite (image is heart.fill)
        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
            
            NotificationCenter.default.post(name: deleteFavorite, object: nil, userInfo: ["anecdote" : anecdote])
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
            
            NotificationCenter.default.post(name: saveFavorite, object: nil, userInfo: ["anecdote" : anecdote])
        }
    }
    
}
