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
}
