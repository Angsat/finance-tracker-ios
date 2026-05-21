//
//  Double+Currency.swift
//  FinanceTracker
//
//  Created by Angsat on 21.05.2026.
//

import Foundation

extension Double {

    func asCurrency() -> String {

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency

        formatter.maximumFractionDigits = 2

        formatter.currencyCode = "USD"

        return formatter.string(
            from: NSNumber(value: self)
        ) ?? "\(self)"
    }
}
