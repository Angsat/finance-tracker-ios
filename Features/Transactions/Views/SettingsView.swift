//
//  SettingsView.swift
//  FinanceTracker
//
//  Created by Angsat on 22.05.2026.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Query
    private var transactions: [Transaction]
    @AppStorage("appTheme")
    private var appTheme = AppTheme.system.rawValue
    @State private var showDeleteConfirmation = false
    private func clearAllTransactions() {

        for transaction in transactions {

            modelContext.delete(transaction)
        }
    }
    var body: some View {

        NavigationStack {


            Form {

                Section("About") {

                    Text("Finance Tracker")

                    Text("Version 1.0")
                }
                Section("Appearance") {

                    Picker(
                        "Theme",
                        selection: $appTheme
                    ) {

                        ForEach(
                            AppTheme.allCases,
                            id: \.self
                        ) { theme in

                            Text(theme.rawValue)
                                .tag(theme.rawValue)
                        }
                    }
                }

                Section("Data") {

                    Button(
                        "Clear All Transactions",
                        role: .destructive
                    ) {

                        showDeleteConfirmation = true
                    }
                }
            }
            .confirmationDialog(
                "Delete all transactions?",
                isPresented: $showDeleteConfirmation
            ) {

                Button(
                    "Delete All",
                    role: .destructive
                ) {
                    clearAllTransactions()
                }

                Button(
                    "Cancel",
                    role: .cancel
                ) {

                }

            } message: {

                Text(
                    "This action cannot be undone."
                )
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
