//
//  TitleCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 27/01/2022.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    static let identifier = "TitleCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TitleCollectionViewCell", bundle: nil)
    }
    
     
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.numberOfLines = 0
        label.text = """
 La meilleure façon d'apprendre, comprendre, se tester.
 """
    }

}
