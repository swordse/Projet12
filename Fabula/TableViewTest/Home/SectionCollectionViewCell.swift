//
//  SectionCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 23/12/2021.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sectionImage: UIImageView!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var sectionText: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    static let identifier = "SectionCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        
    }
    
    func setCell(categorie: Section) {
//        let image = categorie.icon.withRenderingMode(.alwaysTemplate)
//        sectionImage.image = image
//        sectionImage.tintColor = categorie.color
        
        sectionImage.image = categorie.icon
        sectionLabel.text = categorie.title
        sectionText.text = categorie.text
//        backView.backgroundColor = UIColor(named: "lightBlue")
        backView.backgroundColor = categorie.color
        
        sectionLabel.contentMode = .top
    }

}
