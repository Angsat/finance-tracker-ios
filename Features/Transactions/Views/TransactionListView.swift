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
    var body: some View {

        NavigationStack {

            List {

                ForEach(transactions) { transaction in

                    VStack(alignment: .leading) {

                        Text(transaction.category)

                        Text("\(transaction.amount)")
                    }
                }
                .onDelete(perform: deleteTransaction)
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
