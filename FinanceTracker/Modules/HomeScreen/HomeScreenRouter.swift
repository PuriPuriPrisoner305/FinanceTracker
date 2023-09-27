//
//  HomeScreenRouter.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 17/08/23.
//

import Foundation
import UIKit

class HomeScreenRouter {
    func showView() -> HomeScreenView {
        let storyboardID = String(describing: HomeScreenView.self)
        let view = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = view.instantiateViewController(withIdentifier: storyboardID) as? HomeScreenView else {
            fatalError()
        }
        return view
    }
    
    func navigateToEditTransaction(navigation: UINavigationController, data: (TransactionDetail, CategoryData)) {
        let view = TransactionRouter().showView(data: data.0, category: data.1)
        view.hidesBottomBarWhenPushed = true
        navigation.pushViewController(view, animated: true)
    }
    
}
