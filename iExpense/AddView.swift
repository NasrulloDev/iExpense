//
//  AddView.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 02/02/24.
//
import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
//
//    @State private var name = "Expense name"
//    @State private var type = "Personal"
//    @State private var amount = 0.0
//    
//    var expenses: Expenses
    @Bindable var expenseItem: ExpenseItem
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $expenseItem.name)
                
                Picker("Type", selection: $expenseItem.type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $expenseItem.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($expenseItem.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save"){
                    modelContext.insert(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let expenseItem = ExpenseItem(name: "Taxi", type: "Business", amount: 25.00)
        return AddView(expenseItem: expenseItem)
            .modelContainer(container)
    }catch{
        return Text("Failed to create container: \(error.localizedDescription)")
    }
    
}
