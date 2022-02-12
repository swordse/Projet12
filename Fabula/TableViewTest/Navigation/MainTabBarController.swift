//
//  MainTabBarController.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 17/12/2021.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        homeCoordinator.start()
        roundedTabBar()
        viewControllers = [homeCoordinator.navigationController]
        
    }
    
    func roundedTabBar() {
        let layer = CAShapeLayer()
            layer.path = UIBezierPath(roundedRect: CGRect(x: 20, y: tabBar.bounds.minY - 7, width: tabBar.bounds.width - 40, height: tabBar.bounds.height + 14), cornerRadius: 15).cgPath
//            layer.shadowColor = UIColor.lightGray.cgColor
//            layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//            layer.shadowRadius = 25.0
//            layer.shadowOpacity = 0.3
            layer.borderWidth = 1.0
            layer.opacity = 1.0
            layer.isHidden = false
            layer.masksToBounds = false
        layer.fillColor = UIColor(named: "DeepDeepBlue")?.cgColor
//        tabBar.tintColor = UIColor.deepBlue
//        tabBar.barTintColor = UIColor.deepBlue
        
//        tabBar.backgroundColor = UIColor.green
       
            tabBar.layer.insertSublayer(layer, at: 0)
        
        
//            if let items = tabBar.items {
//                items.forEach { item in
//                    item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
//                }
//            }

        tabBar.itemWidth = 40.0
            tabBar.itemPositioning = .centered
    }
}
