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

    var body: some View {

        NavigationStack {

            List(transactions) { transaction in

                VStack(alignment: .leading) {

                    Text(transaction.category)

                    Text("\(transaction.amount)")
                }
            }
            .navigationTitle("Finance Tracker")
        }
    }
}

#Preview {
    TransactionListView()
}
