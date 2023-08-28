//
//  CustomTabBarRouter.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 21/08/23.
//

import UIKit

class CustomTabBarRouter {
    
    func showView() -> CustomTabBarController {
        let storyboardId = String(describing: CustomTabBarController.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? CustomTabBarController else {
            fatalError("Error loading Storyboard")
        }
        return view
    }
    func navigateToHome() -> UIViewController {
        let homeScreen = HomeScreenRouter().showView()
        homeScreen.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        homeScreen.tabBarItem.tag = 0
        return homeScreen
    }
    
    func navigateToHome2() -> UINavigationController {
        let homeScreen = UINavigationController(rootViewController: HomeScreenRouter().showView())
        homeScreen.tabBarItem = UITabBarItem(
            title: "Jome",
            image: UIImage(systemName: "book"),
            selectedImage: UIImage(systemName: "book.fill"))
        homeScreen.tabBarItem.tag = 1
        return homeScreen
    }
    
    func tabbarController() -> [UIViewController] {
        return [navigateToHome(), navigateToHome2()]
    }
    
    func navigateToNewTransaction(navigation: UINavigationController) {
        let view = NewTransactionRouter().showView()
        view.hidesBottomBarWhenPushed = true
        navigation.pushViewController(view, animated: true)
    }
}

