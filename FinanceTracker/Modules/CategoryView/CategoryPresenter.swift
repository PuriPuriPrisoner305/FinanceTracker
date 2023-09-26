//
//  CategoryPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 19/09/23.
//

import Foundation
import UIKit

class CategoryPresenter {
    var categories: [CategoryData]
    var transType: ChartDataType
    
    init(transType: ChartDataType = .expense) {
        self.categories = transType == .expense ? CategoryEntity.expenseCategories : CategoryEntity.incomeCategories
        self.transType = .expense
    }
    
    func setupCategoryData() {
        categories = transType == .expense ? CategoryEntity.expenseCategories : CategoryEntity.incomeCategories
    }
}
