//
//  ActivityRing.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/02/2022.
//

import Foundation
import QuartzCore
import UIKit

extension UIView {
    
    func createActivityRing(view: UIView) -> CAShapeLayer {
       
        let shape = CAShapeLayer()
        
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 80, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 20
        shape.strokeColor = UIColor(named: "green")?.cgColor
        shape.fillColor = UIColor.deepBlue?.cgColor
        shape.strokeEnd = 0.5
        
        view.layer.addSublayer(shape)
        return shape
//        layer.addSublayer(shape)
    }
    
    // need to add shape to view.layer
    
    func animateActivityRing(to value: CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return animation
    }
    
    // need to add animation to
    
}
