//
//  MakeCommentTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 20/01/2022.
//

import UIKit
/// protocol to inform detail anecdote about the current button (addcomment or connexion)
protocol WhichButtonTappedProtocol {
    func buttonTapped(isConnexion: Bool, isSubmit: Bool)
}
// cell for addcomment button. The connexion button is displayed if user is not connected, else the addComment button is displayed
class MakeCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var connexionButton: UIButton!
    
    var whichButtonTappedDelegate: WhichButtonTappedProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentTextfield.delegate = self
        backView.layer.cornerRadius = 15
        submitButton.layer.cornerRadius = 15
        submitButton.setShadow()
        connexionButton.layer.cornerRadius = 15
        connexionButton.setShadow()
        commentTextfield.layer.cornerRadius = 15
        commentTextfield.placeholder = "votre commentaire"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func submitCommentButtonTapped(_ sender: Any) {
        whichButtonTappedDelegate.buttonTapped(isConnexion: false, isSubmit: true)
    }
    
    @IBAction func connexionButtonTapped(_ sender: Any) {
        whichButtonTappedDelegate.buttonTapped(isConnexion: true, isSubmit: false)
    }
    
    func setCell(isConnected: Bool) {
        if !isConnected {
            connexionButton.isHidden = false
            commentTextfield.isHidden = true
            submitButton.isHidden = true
        } else {
            commentTextfield.isHidden = true
            connexionButton.isHidden = true
            submitButton.isHidden = false
        }
    }
}

extension MakeCommentTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return commentTextfield.resignFirstResponder()
    }
}
