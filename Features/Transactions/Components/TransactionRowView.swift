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

        HStack(spacing: 16) {

            ZStack {

                Circle()
                    .fill(iconBackgroundColor)
                    .frame(width: 44, height: 44)

                Image(systemName: iconName)
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {

                Text(transaction.category)
                    .font(.headline)

                if let note = transaction.note,
                   !note.isEmpty {

                    Text(note)
                        .font(.caption)
                        .foregroundStyle(.secondary)
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
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
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
    private var iconName: String {

        switch transaction.category.lowercased() {

        case "food":
            return "fork.knife"

        case "transport":
            return "car.fill"

        case "shopping":
            return "bag.fill"

        case "salary":
            return "banknote.fill"

        case "health":
            return "cross.case.fill"

        case "entertainment":
            return "gamecontroller.fill"

        default:
            return transaction.type == .income
                ? "arrow.down"
                : "arrow.up"
        }
    }

    private var iconBackgroundColor: Color {

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
