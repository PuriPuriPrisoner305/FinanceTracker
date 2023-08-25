//
//  HomeScreenPresenter.swift
//  FinanceTracker
//
//  Created by ardy on 25/08/23.
//

import UIKit

class HomeScreenPresenter {
    var router = HomeScreenRouter()
    
    var transactionData: [TransactionDetail] = [
        TransactionDetail(name: "Spotify", description: "John's Card", amount: 5000, date: Date()),
        TransactionDetail(name: "Amazon Prime", description: "Debi's Card", amount: 8000, date: Date()),
        TransactionDetail(name: "Hulu", description: "Jessica's Card", amount: 4200, date: Date()),
        TransactionDetail(name: "Netflix", description: "Brandon's Card", amount: 1500, date: Date()),
        TransactionDetail(name: "Spotify", description: "John's Card", amount: 5000, date: Date()),
        TransactionDetail(name: "Amazon Prime", description: "Debi's Card", amount: 8000, date: Date()),
        TransactionDetail(name: "Hulu", description: "Jessica's Card", amount: 4200, date: Date()),
        TransactionDetail(name: "Netflix", description: "Brandon's Card", amount: 1500, date: Date()),
        TransactionDetail(name: "Spotify", description: "John's Card", amount: 5000, date: Date()),
        TransactionDetail(name: "Amazon Prime", description: "Debi's Card", amount: 8000, date: Date()),
        TransactionDetail(name: "Hulu", description: "Jessica's Card", amount: 4200, date: Date()),
        TransactionDetail(name: "Netflix", description: "Brandon's Card", amount: 1500, date: Date())
    ]

}
