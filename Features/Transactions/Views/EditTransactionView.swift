//
//  EditTransactionView.swift
//  FinanceTracker
//
//  Created by Angsat on 21.05.2026.
//

import SwiftUI
import SwiftData

struct EditTransactionView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Bindable var transaction: Transaction

    var body: some View {

        NavigationStack {

            Form {

                Section("Amount") {

                    TextField(
                        "Enter amount",
                        value: $transaction.amount,
                        format: .number
                    )
                }

                Section("Type") {

                    Picker(
                        "Type",
                        selection: $transaction.type
                    ) {

                        Text("Income")
                            .tag(TransactionType.income)

                        Text("Expense")
                            .tag(TransactionType.expense)
                    }
                    .pickerStyle(.segmented)
                }

                Section("Category") {

                    Picker(
                        "Category",
                        selection: $transaction.category
                    ) {

                        ForEach(
                            TransactionCategory.allCases,
                            id: \.self
                        ) { category in

                            Text(category.rawValue)
                                .tag(category.rawValue)
                        }
                    }
                }

                Section("Note") {

                    TextField(
                        "Optional note",
                        text: Binding(
                            get: {
                                transaction.note ?? ""
                            },
                            set: {
                                transaction.note = $0
                            }
                        )
                    )
                }
            }
            .navigationTitle("Edit Transaction")

            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {

                        dismiss()
                    }
                }
            }
        }
    }
}
