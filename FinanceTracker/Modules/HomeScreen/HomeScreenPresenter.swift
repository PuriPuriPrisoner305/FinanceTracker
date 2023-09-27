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
        TransactionDetail(description: "John's Card", categoryName: "Spotify", categoryImage: "music.note.tv.fill", amount: 5000, date: Date(), currency: "Rp", transType: .expense)
    ]
    
    var context: NSManagedObjectContext?

    var router = HomeScreenRouter()
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func loadData() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            for entity in results {
                let trans = TransactionDetail(description: entity.transDesc,
                                              categoryName: entity.categoryName,
                                              categoryImage: entity.categoryImage,
                                              amount: entity.transAmount,
                                              date: entity.transTime,
                                              currency: entity.transCurrency,
                                              transType: ChartDataType(rawValue: entity.transType) ?? .expense)
                transactionData.insert(trans, at: 0)            }
        } catch {
            print(error)
        }
    }
}
