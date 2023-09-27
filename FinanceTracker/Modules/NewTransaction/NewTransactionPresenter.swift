//
//  NewTransactionPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 28/08/23.
//

import UIKit
import CoreData

class NewTransactionPresenter {
    var transType: ChartDataType = .expense
    var selectedCategory: CategoryData = CategoryEntity.expenseCategories[0]
    var transAmount: String = ""
    var transDesc: String = ""
    var transactionTime: Date = Date()
    
    var context: NSManagedObjectContext?

    var router = NewTransactionRouter()
    
    func setupCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveData() {
        guard let context = context else { return }
        if let newTrans = NSEntityDescription.insertNewObject(forEntityName: "Transactions", into: context) as? Transactions {
            newTrans.id = UUID()
            newTrans.categoryName = selectedCategory.name
            newTrans.categoryImage = selectedCategory.image
            let amount = transAmount.filter("0123456789.".contains)
            newTrans.transAmount = Double(amount) ?? 0
            newTrans.transDesc = transDesc
            newTrans.transCurrency = "Rp"
            newTrans.transTime = transactionTime
            newTrans.transType = transType.value
        }

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func navigateToCategoryView(navigation: UINavigationController, delegate: CategoryViewDelegate) {
        router.navigateToCategoryView(navigation: navigation, transType: transType, delegate: delegate)
    }
    
    func navigateToDatePickerView(navigation: UINavigationController, delegate: DatePickerViewDelegate) {
        router.navigateToDatePickerView(navigation: navigation, date: transactionTime, delegate: delegate)
    }
}
