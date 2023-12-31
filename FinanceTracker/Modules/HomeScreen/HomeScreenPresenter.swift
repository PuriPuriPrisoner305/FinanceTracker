//
//  HomeScreenPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 25/08/23.
//

import UIKit
import CoreData

class HomeScreenPresenter {
    var transactionData: [TransactionDetail] = [
        TransactionDetail(id: UUID(), description: "John's Card", categoryName: "Spotify", categoryImage: "music.note.tv.fill", amount: 5000, date: Date(), currency: "Rp", transType: .expense)
    ]
    
    var context: NSManagedObjectContext?

    var router = HomeScreenRouter()
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func loadData() {
        guard let context = context else { return }
        transactionData = []
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            for entity in results {
                let trans = TransactionDetail(id: entity.id,
                                              description: entity.transDesc,
                                              categoryName: entity.categoryName,
                                              categoryImage: entity.categoryImage,
                                              amount: entity.transAmount,
                                              date: entity.transTime,
                                              currency: entity.transCurrency,
                                              transType: ChartDataType(rawValue: entity.transType) ?? .expense)
                transactionData.insert(trans, at: 0)
            }
            transactionData.sort { lhs, rhs in
                lhs.date > rhs.date
            }
        } catch {
            print(error)
        }
    }
    
    func setupTotalIncome() -> String {
        let income = transactionData.filter({$0.transType == .income})
        var totalIncome = 0.0
        for trans in income {
            totalIncome += trans.amount
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: totalIncome)) ?? "0"
    }
    
    func setupTotalExpense() -> String {
        let expense = transactionData.filter({$0.transType == .expense})
        var totalExpense = 0.0
        for trans in expense {
            totalExpense += trans.amount
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: totalExpense)) ?? "0"
    }
    
    func navigateToEditTransaction(navigation: UINavigationController, index: Int) {
        let transData = transactionData[index]
        router.navigateToEditTransaction(navigation: navigation, data: (transData, CategoryData(image: transData.categoryImage, name: transData.categoryName)))
    }
}
