//
//  TransactionListView.swift
//  FinanceTracker
//
//  Created by Angsat on 15.05.2026.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {

    @Query(
        sort: \Transaction.date,
        order: .reverse
    )
    private var transactions: [Transaction]
    @State private var showAddTransaction = false
    @Environment(\.modelContext)
    private var modelContext
    private var totalIncome: Double {

        transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }

    private var totalExpense: Double {

        transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }

    private var totalBalance: Double {

        totalIncome - totalExpense
    }
    var body: some View {

        NavigationStack {
            VStack {
                
                VStack(spacing: 12) {
                    
                    Text("Balance: \(totalBalance.asCurrency())")
                    
                    Text("Income: \(totalIncome.asCurrency())")

                    Text("Expense: \(totalExpense.asCurrency())")
                }
                .padding()
                
                List {
                    if transactions.isEmpty {

                        VStack(spacing: 16) {

                            Image(systemName: "wallet.pass")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)

                            Text("No Transactions Yet")

                            Text(
                                "Tap + to add your first transaction"
                            )
                            .font(.caption)
                            .foregroundStyle(.gray)
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )

                    } else {

                        List {

                            ForEach(transactions) { transaction in

                                TransactionRowView(
                                    transaction: transaction
                                )
                            }
                            .onDelete(perform: deleteTransaction)
                        }
                    }
                }
                .navigationTitle("Finance Tracker")
                
                .toolbar {
                    
                    Button {
                        
                        showAddTransaction = true
                        
                    } label: {
                        
                        Image(systemName: "plus")
                    }
                }
                
                .sheet(isPresented: $showAddTransaction) {
                    
                    AddTransactionView()
                }
                
            }
        }
    }
    private func deleteTransaction(
        at offsets: IndexSet
    ) {

        for index in offsets {

            let transaction = transactions[index]

            modelContext.delete(transaction)
        }
    }
}

#Preview {
    TransactionListView()
}
