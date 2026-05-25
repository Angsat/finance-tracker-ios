//
//  AnalyticsView.swift
//  FinanceTracker
//
//  Created by Angsat on 22.05.2026.
//

import SwiftUI
import SwiftData
import Charts

struct AnalyticsView: View {


    @Query private var transactions: [Transaction]

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

    private var balance: Double {

        totalIncome - totalExpense
    }
    private var categoryTotals: [CategoryTotal] {

        let expenses = transactions.filter {
            $0.type == .expense
        }

        let grouped = Dictionary(
            grouping: expenses,
            by: { $0.category }
        )

        return grouped.map { category, transactions in

            let total = transactions.reduce(0) {
                $0 + $1.amount
            }

            return CategoryTotal(
                category: category,
                total: total
            )
        }
        .sorted { $0.total > $1.total }
    }
    var body: some View {

        NavigationStack {

            ScrollView(.vertical, showsIndicators: true) {

                VStack(spacing: 16) {

                    analyticsCard(
                        title: "Balance",
                        value: balance.asCurrency(),
                        systemImage: "wallet.bifold.fill"
                    )

                    analyticsCard(
                        title: "Income",
                        value: totalIncome.asCurrency(),
                        systemImage: "arrow.down.circle.fill"
                    )

                    analyticsCard(
                        title: "Expense",
                        value: totalExpense.asCurrency(),
                        systemImage: "arrow.up.circle.fill"
                    )

                    analyticsCard(
                        title: "Transactions",
                        value: "\(transactions.count)",
                        systemImage: "list.bullet.rectangle"
                    )
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Expenses by Category")
                            .font(.headline)

                        ForEach(categoryTotals) { item in

                            HStack {

                                Text(item.category)
                               
                                Spacer()


                                Text(item.total.asCurrency())
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Expense Chart")
                            .font(.headline)

                        Chart {

                            ForEach(categoryTotals) { item in

                                BarMark(
                                    x: .value("Amount", item.total),
                                    y: .value("Category", item.category)
                                )
                            }
                        }
                        .frame(height: 220)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                        
                        Color.clear
                            .frame(height: 40)
                    }
                }
                
                .padding()
                
            }
            .navigationTitle("Analytics")
            
        }
    }

    @ViewBuilder
    private func analyticsCard(
        title: String,
        value: String,
        systemImage: String
    ) -> some View {

        HStack {

            Image(systemName: systemImage)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

//#Preview {
//    AnalyticsView()
//}
