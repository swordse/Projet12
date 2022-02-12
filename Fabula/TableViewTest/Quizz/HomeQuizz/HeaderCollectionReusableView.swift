//
//  HeaderCollectionReusableView.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollection"
    
//    private let backView: UIView = {
//        let backView = UIView()
//        backView.backgroundColor = UIColor(named: "lightBlue")
//        return backView
//    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    public func configure(text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        backView.addSubview(label)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        backView.frame = CGRect(x: 0, y: 0, width: (superview?.frame.width)! - 20, height: 50)
        
//        backView.frame = bounds
//        backView.layer.cornerRadius = 15
//        label.frame = backView.bounds
        label.frame = bounds
        
    }
    
}
