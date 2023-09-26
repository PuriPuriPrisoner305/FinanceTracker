//
//  NewTransactionRouter.swift
//  FinanceTracker
//
//  Created by ardy on 28/08/23.
//

import UIKit

class NewTransactionRouter {
    func showView() -> NewTransactionView {
        let storyboardID = String(describing: NewTransactionView.self)
        let view = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = view.instantiateViewController(withIdentifier: storyboardID) as? NewTransactionView else {
            fatalError()
        }
        return view
    }
    
    func navigateToCategoryView(navigation: UINavigationController, transType: ChartDataType, delegate: CategoryViewDelegate) {
        let view = CategoryRouter().showView(transType: transType)
        view.delegate = delegate
        view.isModalInPresentation = true
        navigation.pushViewController(view, animated: true)
    }
    
    func navigateToDatePickerView(navigation: UINavigationController, date: Date, delegate: DatePickerViewDelegate) {
        guard let view = DatePickerRouter().showView() else { return }
        view.delegate = delegate
        view.selectedDate = date
        navigation.present(view, animated: true)
    }
}
