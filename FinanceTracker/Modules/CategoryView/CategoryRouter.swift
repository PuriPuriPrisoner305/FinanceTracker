//
//  CategoryRouter.swift
//  FinanceTracker
//
//  Created by ardy on 19/09/23.
//

import UIKit

class CategoryRouter {
    func showView(transType: ChartDataType) -> CategoryView {
        let storyboardID = String(describing: CategoryView.self)
        let view = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = view.instantiateViewController(withIdentifier: storyboardID) as? CategoryView else {
            fatalError()
        }
        let presenter = CategoryPresenter(transType: transType)
        view.presenter = presenter
        return view
    }
    
}
