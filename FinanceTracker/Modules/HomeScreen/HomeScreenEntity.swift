//
//  HomeScreenEntity.swift
//  FinanceTracker
//
//  Created by Ardyansyah Wijaya on 25/08/23.
//

import UIKit

enum ChartDataType: String, Codable {
    case income
    case expense
    
    var value: String {
        switch self {
        case .expense:
            return "expense"
        default:
            return "income"
        }
    }
}

struct TransactionDetail: Codable {
    var description: String
    var categoryName, categoryImage: String
    var amount: Double
    var date: Date
    var currency: String
    var transType: ChartDataType
}
