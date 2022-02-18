//
//  MakeCommentTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 20/01/2022.
//

import UIKit

//protocol CommentTappedProtocol {
//    func commentTapped(comment: String?)
//}

protocol WhichButtonTappedProtocol {
    func buttonTapped(isConnexion: Bool, isSubmit: Bool)
}

class MakeCommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backView: UIView!
    
   
    @IBOutlet weak var commentTextfield: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var connexionButton: UIButton!
    
//    var commentTappedDelegate: CommentTappedProtocol!
    
    var whichButtonTappedDelegate: WhichButtonTappedProtocol!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentTextfield.delegate = self
        backView.layer.cornerRadius = 15
        submitButton.layer.cornerRadius = 15
        submitButton.setShadow()
//        submitButton.layer.borderWidth = 1
//        submitButton.layer.borderColor = UIColor.white.cgColor
        connexionButton.layer.cornerRadius = 15
        connexionButton.setShadow()
//        connexionButton.layer.borderWidth = 1
//        connexionButton.layer.borderColor = UIColor.white.cgColor
        commentTextfield.layer.cornerRadius = 15
        commentTextfield.placeholder = "votre commentaire"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func commentTextReturnTapped(_ sender: UITextField) {
        print("tap")
        textFieldShouldReturn(sender)
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
