//
//  SectionHeaderCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 27/01/2022.
//

import UIKit

class SectionHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    static let identifier = "SectionHeaderCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionHeaderCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Qu'allez-vous apprendre aujourd'hui?"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        
    }

}
