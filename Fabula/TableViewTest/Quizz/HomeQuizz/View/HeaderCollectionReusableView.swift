//
//  HeaderCollectionReusableView.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import UIKit
// header to display "Categories" and "Quizz" as header for the collectionView sections
final class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollection"
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    public func configure(text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
