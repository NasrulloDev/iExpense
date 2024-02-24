//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 01/02/24.
//
import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
