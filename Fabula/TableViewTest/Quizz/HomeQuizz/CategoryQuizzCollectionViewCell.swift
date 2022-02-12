//
//  CategoryQuizzCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import UIKit

class CategoryQuizzCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "categoryCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryQuizzCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(category: QuizzCategoryInfo) {

//        backView.layoutIfNeeded()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = backView.bounds
//        gradientLayer.colors = [CGColor(red: 0.541, green: 0.137, blue: 0.529, alpha: 1),CGColor(red: 0.987, green: 0.019, blue: 0.085, alpha: 1)]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.cornerRadius = 15
//
//        backView.layer.insertSublayer(gradientLayer, at: 0)
        backView.layer.cornerRadius = 15
        backView.backgroundColor = category.color
        categoryLabel.text = category.name
        categoryLabel.textColor = .white
        categoryLabel.font = categoryLabel.font.withSize(18)
        categoryImage.image = category.image
        
        categoryLabel.textColor = .white
    }
    
    func borderIsSet(_ isTrue: Bool) {
        backView.layer.borderColor = (UIColor.label).cgColor
        isTrue ? (backView.layer.borderWidth = 2) : (backView.layer.borderWidth = 0)
    }
    
    func tiltImage() {
        categoryImage.tilt()
    }

}
