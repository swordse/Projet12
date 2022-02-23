//
//  FavoriteTableViewCell.swift
//  Fabula
//
//  Created by Raphaël Goupille on 22/02/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    
    func setCell() {
        label.text =
        """
        Vous n'avez pas de favoris.
        Pour en ajouter, cliquez sur le coeur dans le détail d'une anecdote.
"""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
