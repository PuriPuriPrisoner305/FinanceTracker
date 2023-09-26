//
//  DatePickerRouter.swift
//  FinanceTracker
//
//  Created by ardy on 24/09/23.
//

import UIKit

class DatePickerRouter {
    func showView() -> DatePickerView? {
        let storyboardId = String(describing: DatePickerView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: .main)
        if let popUpView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? DatePickerView {
            popUpView.modalPresentationStyle = .overCurrentContext
            popUpView.modalTransitionStyle = .crossDissolve
            return popUpView
        }
        return nil
    }
    
}
