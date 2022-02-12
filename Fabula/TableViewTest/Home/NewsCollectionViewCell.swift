//
//  NewsCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 23/12/2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gradientView: UIView!
  
//    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    static var identifier = "NewsCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsCollectionViewCell", bundle: nil)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradientView.layer.cornerRadius = 15
        
//        imageView.layer.cornerRadius = imageView.bounds.width/2
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = UIColor(named: "deepBlue")
    }
    
    func setCell(new: News) {
//        set gradient
        
        gradientView.backgroundColor = UIColor(named: "darkblue")
        gradientView.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [CGColor(red: 0.541, green: 0.137, blue: 0.529, alpha: 1),CGColor(red: 0.987, green: 0.019, blue: 0.085, alpha: 1), CGColor(red: 0.949, green: 0.443, blue: 0.129, alpha: 1)]
        gradientLayer.locations = [0, 1, 0.5, 0.8, 0.7, 1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.cornerRadius = 15
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
//        titleLabel.text = new.title
        textLabel.text = new.text
    }
}
