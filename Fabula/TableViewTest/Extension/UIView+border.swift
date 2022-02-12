//
//  UIView+border.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 06/01/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func blackBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5

    }
}
