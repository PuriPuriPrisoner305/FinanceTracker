//
//  TransactionRouter.swift
//  FinanceTracker
//
//  Created by ardy on 27/09/23.
//

import UIKit

class TransactionRouter {
    func showView(data: TransactionDetail, category: CategoryData) -> TransactionView {
        let storyboardID = String(describing: TransactionView.self)
        let view = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = view.instantiateViewController(withIdentifier: storyboardID) as? TransactionView else {
            fatalError()
        }
        let presenter = TransactionPresenter(data: data, category: category)
        view.presenter = presenter
        return view
    }
    
    func navigateToCategoryView(navigation: UINavigationController, transType: ChartDataType, delegate: CategoryViewDelegate) {
        let view = CategoryRouter().showView(transType: transType)
        view.delegate = delegate
        view.isFromEditing = true
        view.isModalInPresentation = true
        navigation.pushViewController(view, animated: true)
    }
    
    func navigateToDatePickerView(navigation: UINavigationController, date: Date, delegate: DatePickerViewDelegate) {
        guard let view = DatePickerRouter().showView() else { return }
        view.delegate = delegate
        view.selectedDate = date
        navigation.navigationBar.isHidden = false
        navigation.present(view, animated: true)
    }
}
