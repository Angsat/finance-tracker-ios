//
//  Item.swift
//  FinanceTracker
//
//  Created by Angsat on 15.05.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
