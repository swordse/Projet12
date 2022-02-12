//
//  UIView+animation.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func tilt() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(rotationAngle: 0.5)
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.transform = .identity
            }, completion: nil)
        }

//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: []) {
//            self.transform = CGAffineTransform(rotationAngle: 0.4)
//        } completion: { bool in
//            if bool {
//                self.transform = .identity
//            }
//        }
    }
    
    func scaleMinAnim() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: nil)
    }
    
    func scaleMaxAnim(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.transform = .identity
        }, completion: completion)
    }
    
    func translateRightAnim(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }, completion: completion)
    }
    
    func translateLeftAnim(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }, completion: completion)
    }
    
    func setBackAnim(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            self.transform = .identity
        }, completion: completion)
    }
    
//    func redBackgroundAnim(completion: ((Bool) -> Void)?) {
//        UIView.animate(withDuration: 0.1, delay: 0, options:.curveLinear , animations: {
//            self.backgroundColor = .red
//        }, completion: completion)
//    }
//    
//    func greenBackgroundAnim(completion: ((Bool) -> Void)?) {
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
//            self.backgroundColor = .green
//        }, completion: completion)
//    }
//    
//    func blueBackgroundAnim() {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
//            self.backgroundColor = UIColor(named: "lightBlue")
//        }, completion: nil)
//    }
}
