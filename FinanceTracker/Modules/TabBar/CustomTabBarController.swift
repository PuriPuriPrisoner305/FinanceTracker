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
        self.customTabBar.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.customTabBar.unselectedItemTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.delegate = self
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else { return true }
        return true
    }
}
