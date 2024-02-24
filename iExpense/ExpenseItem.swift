//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 24/02/24.
//

import Foundation
import SwiftData

@Model
class ExpenseItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
