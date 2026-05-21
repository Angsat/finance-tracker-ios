//
//  TransactionRowView.swift
//  FinanceTracker
//
//  Created by Angsat on 21.05.2026.
//

import SwiftUI

struct TransactionRowView: View {

    let transaction: Transaction

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text(transaction.category)
                    .font(.headline)

                if let note = transaction.note,
                   !note.isEmpty {

                    Text(note)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {

                Text(amountText)
                    .fontWeight(.semibold)
                    .foregroundStyle(amountColor)

                Text(
                    transaction.date,
                    style: .date
                )
                .font(.caption)
                .foregroundStyle(.gray)
            }
        }
        .padding(.vertical, 4)
    }

    private var amountText: String {

        let sign = transaction.type == .income
            ? "+"
            : "-"

        return "\(sign)\(transaction.amount.asCurrency())"
    }

    private var amountColor: Color {

        transaction.type == .income
            ? .green
            : .red
    }
}

#Preview {

    TransactionRowView(
        transaction: Transaction(
            amount: 1200,
            type: .expense,
            category: "Food"
        )
    )
}
