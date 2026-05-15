//
//  Transaction.swift
//  FinanceTracker
//
//  Created by Angsat on 15.05.2026.
//

import Foundation
import SwiftData

@Model
final class Transaction {

    var id: UUID
    var amount: Double
    var type: TransactionType
    var category: String
    var date: Date
    var note: String?

    init(
        amount: Double,
        type: TransactionType,
        category: String,
        date: Date = .now,
        note: String? = nil
    ) {
        self.id = UUID()
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.note = note
    }
}
