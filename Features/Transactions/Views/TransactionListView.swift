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
    @State private var selectedFilter = "All"
    @Environment(\.modelContext)
    private var modelContext
    private var filteredTransactions: [Transaction] {

        switch selectedFilter {

        case "Income":
            return transactions.filter {
                $0.type == .income
            }

        case "Expense":
            return transactions.filter {
                $0.type == .expense
            }

        default:
            return transactions
        }
    }
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
                
                VStack(alignment: .leading, spacing: 16) {

                    Text("Total Balance")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(totalBalance.asCurrency())
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {

                        VStack(alignment: .leading) {

                            Text("Income")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(totalIncome.asCurrency())
                                .foregroundStyle(.green)
                        }

                        Spacer()

                        VStack(alignment: .trailing) {

                            Text("Expenses")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(totalExpense.asCurrency())
                                .foregroundStyle(.red)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .padding(.horizontal)
                .padding()
                Picker(
                    "Filter",
                    selection: $selectedFilter
                ) {

                    Text("All")
                        .tag("All")

                    Text("Income")
                        .tag("Income")

                    Text("Expense")
                        .tag("Expense")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
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

                            ForEach(filteredTransactions) { transaction in

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
