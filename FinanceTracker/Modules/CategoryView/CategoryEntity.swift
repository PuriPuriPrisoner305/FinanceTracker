//
//  CategoryEntity.swift
//  FinanceTracker
//
//  Created by ardy on 19/09/23.
//

import Foundation

class CategoryEntity {
    static let expenseCategories: [CategoryData] =
    [
        CategoryData(image: "fork.knife", name: "Food"),
        CategoryData(image: "cup.and.saucer.fill", name: "Coffee"),
        CategoryData(image: "bag.fill", name: "Groceries"),
        CategoryData(image: "popcorn.fill", name: "Fun"),
        CategoryData(image: "camera.filters", name: "Others")
    ]
    
    static let incomeCategories: [CategoryData] =
    [
        CategoryData(image: "dollarsign.circle.fill", name: "Salary"),
        CategoryData(image: "plus.app.fill", name: "Bonus"),
        CategoryData(image: "camera.filters", name: "Others")
    ]
}



struct CategoryData {
    let image: String
    let name: String
}

