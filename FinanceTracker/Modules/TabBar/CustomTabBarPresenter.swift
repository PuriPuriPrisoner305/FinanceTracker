//
//  CustomTabBarPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 28/08/23.
//

import UIKit

class CustomTabBarPresenter {
    var router = CustomTabBarRouter()
    
    func navigateToNewTransaction(navigation: UINavigationController) {
        router.navigateToNewTransaction(navigation: navigation)
    }
}
