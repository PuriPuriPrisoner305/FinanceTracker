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
    let name, description: String
    let amount: Int
    let date: Date
}
