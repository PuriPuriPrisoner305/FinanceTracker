//
//  HomeScreenEntity.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 25/08/23.
//

import UIKit

enum ChartDataType {
    case income
    case expense
}

struct TransactionDetail: Codable {
    var description: String
    var categoryName, categoryImage: String
    var amount: Double
    var date: Date
    var currency: String
}
