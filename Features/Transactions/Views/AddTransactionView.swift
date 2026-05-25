//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Angsat on 21.05.2026.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var context

    @State private var amount = ""
    @State private var selectedType: TransactionType = .expense
    @State private var selectedCategory:
    TransactionCategory = .food
    @State private var note = ""

    var body: some View {

        NavigationStack {

            Form {

                Section("Amount") {

                    TextField(
                        "Enter amount",
                        text: $amount
                    )
                    .keyboardType(.decimalPad)
                }

                Section("Type") {

                    Picker("Transaction Type", selection: $selectedType) {

                        Text("Expense")
                            .tag(TransactionType.expense)

                        Text("Income")
                            .tag(TransactionType.income)
                    }
                    .pickerStyle(.segmented)
                }

                Section("Category") {

                    Picker(
                        "Select Category",
                        selection: $selectedCategory
                    ) {

                        ForEach(
                            TransactionCategory.allCases,
                            id: \.self
                        ) { category in

                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                }

                Section("Note") {

                    TextField(
                        "Optional note",
                        text: $note
                    )
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {
                        saveTransaction()
                    }
                }
            }
        }
    }

    private func saveTransaction() {

        guard let amountValue = Double(amount) else {
            return
        }

        let transaction = Transaction(
            amount: amountValue,
            type: selectedType,
            category: selectedCategory.rawValue,
            note: note.isEmpty ? nil : note
        )

        context.insert(transaction)

        dismiss()
    }
}

//#Preview {
//    AddTransactionView()
//}
