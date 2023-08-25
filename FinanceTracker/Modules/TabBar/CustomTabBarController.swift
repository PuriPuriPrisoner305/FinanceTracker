//
//  CustomTabBarController.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 17/08/23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    @IBOutlet weak var customTabBar: CustomTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.viewControllers = CustomTabBarRouter().tabbarController()
        self.customTabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let color = UIColor(red: 146/255.0, green: 146/255.0, blue: 146/255.0, alpha: 1.0)
        self.customTabBar.unselectedItemTintColor = color
        self.customTabBar.backgroundColor = .white
        
        self.customTabBar.standardAppearance.shadowImage = nil
        self.customTabBar.scrollEdgeAppearance?.shadowImage = nil
        self.customTabBar.standardAppearance.shadowColor = nil
        self.customTabBar.scrollEdgeAppearance?.shadowColor = nil

        self.delegate = self
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else { return true }
        return true
    }
}
