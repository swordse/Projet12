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
        tabBar.tintColor = .white
        homeCoordinator.start()
        roundedTabBar()
        viewControllers = [homeCoordinator.navigationController]
    }
    
    func roundedTabBar() {
        let layer = CAShapeLayer()
            layer.path = UIBezierPath(roundedRect: CGRect(x: 20, y: tabBar.bounds.minY - 7, width: tabBar.bounds.width - 40, height: tabBar.bounds.height + 14), cornerRadius: 15).cgPath
            layer.borderWidth = 1.0
            layer.opacity = 1.0
            layer.isHidden = false
            layer.masksToBounds = false
        layer.fillColor = UIColor(named: "DeepDeepBlue")?.cgColor
            tabBar.layer.insertSublayer(layer, at: 0)
        tabBar.itemWidth = 40.0
            tabBar.itemPositioning = .centered
    }
}
