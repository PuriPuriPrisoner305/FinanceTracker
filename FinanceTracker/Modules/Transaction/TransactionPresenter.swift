//
//  TransactionPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 27/09/23.
//

import UIKit
import CoreData

class TransactionPresenter {
    var transactionDetail: TransactionDetail
    
    var context: NSManagedObjectContext
    var router: TransactionRouter
    
    init(data: TransactionDetail, category: CategoryData) {
        self.transactionDetail = data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        router = TransactionRouter()
    }
    
    func saveData() {
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(transactionDetail.id)")

        do {
            let results = try context.fetch(fetchRequest)
            if let trans = results.first {
                trans.categoryName = transactionDetail.categoryName
                trans.categoryImage = transactionDetail.categoryImage
                let amount = String(transactionDetail.amount).filter("0123456789.".contains)
                trans.transAmount = Double(amount) ?? 0
                trans.transDesc = transactionDetail.description
                trans.transCurrency = "Rp"
                trans.transTime = transactionDetail.date
                trans.transType = transactionDetail.transType.value
                
                try context.save()
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func navigateToCategoryView(navigation: UINavigationController, delegate: CategoryViewDelegate) {
        router.navigateToCategoryView(navigation: navigation, transType: transactionDetail.transType, delegate: delegate)
    }
    
    func navigateToDatePickerView(navigation: UINavigationController, delegate: DatePickerViewDelegate) {
        router.navigateToDatePickerView(navigation: navigation, date: transactionDetail.date, delegate: delegate)
    }
}
