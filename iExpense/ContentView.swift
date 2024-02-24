//
//  ContentView.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 01/02/24.
//
import SwiftData
import SwiftUI

//@Observable
//class Expenses {
//    var items = [ExpenseItem]() {
//        didSet{
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    
//    init(){
//        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
//                items = decodedItems
//                return
//            }
//        }
//        
//        items = []
//    }
//    
//}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showAddView = false
    @Query(sort: \ExpenseItem.amount) var expenses: [ExpenseItem]
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Text("Business Expenses")
                        .font(.headline.bold())
                        .underline()
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
//                    .onDelete(perform: removeItems)
                }
                
//                List{
//                    Text("Personal Expenses")
//                        .font(.headline.bold())
//                        .underline()
//                    ForEach(expenses.filter({$0.type == "Personal"})){ item in
//                        HStack{
//                            VStack(alignment: .leading){
//                                Text(item.name)
//                                    .font(.headline)
//                                
//                                Text(item.type)
//                            }
//                            Spacer()
//                            
//                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                .foregroundStyle(item.amount < 100000 ? .green : (item.amount < 1000000 ? .orange : .red))
//                        }
//                    }
//                    .onDelete(perform: removeItems(item))
//
//                }
                
            }
            .navigationTitle("iExpense")
            .toolbar{
                NavigationLink("Add expense") {
                    AddView(expenseItem: ExpenseItem(name: "", type: "Business", amount: 0.0))
//                    Button("Add Expense", systemImage: "plus"){
//                        showAddView = true
//                    }
                }
            }
            .navigationBarBackButtonHidden()
//            .sheet(isPresented: $showAddView){
//                AddView(expenses: expenses)
//            }
                
        }
    }
    
//    func removeItems(item: String){
//        expenses.remove(atOffsets: offsets)
//        modelContext.delete(item)
//    }
}

#Preview {
    ContentView()
}
