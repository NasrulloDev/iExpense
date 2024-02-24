//
//  ContentView.swift
//  iExpense
//
//  Created by Насрулло Исмоилжонов on 01/02/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}
struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Text("Business Expenses")
                        .font(.headline.bold())
                        .underline()
                    ForEach(expenses.items.filter({$0.type == "Business"})){ item in
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
                    .onDelete(perform: removeItems)
                }
                
                List{
                    Text("Personal Expenses")
                        .font(.headline.bold())
                        .underline()
                    ForEach(expenses.items.filter({$0.type == "Personal"})){ item in
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
                    .onDelete(perform: removeItems)
                    
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar{
                NavigationLink("Add expense") {
                    AddView(expenses: expenses)
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
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
