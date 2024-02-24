//
//  ExpensesView.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 24/02/24.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        ForEach(expenses){ item in
            HStack{
                VStack(alignment: .leading){
                    Text(item.name)
                        .font(.headline)
                    
                    Text(item.type)
                }
                Spacer()
                
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle(item.amount < 100000 ? .green : (item.amount < 1000000 ? .orange : .red))
            }
        }
    }
    
    init(neededType: String){
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            expense.type == neededType
        }, sort: \ExpenseItem.amount)
    }
}

#Preview {
    ExpensesView(neededType: "Personal")
        .modelContainer(for: ExpenseItem.self)
}
