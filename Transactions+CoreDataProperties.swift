//
//  Transactions+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by ardy on 26/09/23.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var categoryName: String
    @NSManaged public var categoryImage: String
    @NSManaged public var transDesc: String
    @NSManaged public var transTime: Date
    @NSManaged public var transCurrency: String
    @NSManaged public var transAmount: Double
    @NSManaged public var transType: String

}

extension Transactions : Identifiable {

}
