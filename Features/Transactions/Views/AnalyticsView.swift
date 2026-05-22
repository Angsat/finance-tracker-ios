//
//  AnalyticsView.swift
//  FinanceTracker
//
//  Created by Angsat on 22.05.2026.
//

import SwiftUI

struct AnalyticsView: View {

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Image(systemName: "chart.pie.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("Analytics")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(
                    "Charts and statistics will appear here"
                )
                .foregroundStyle(.secondary)
            }
            .navigationTitle("Analytics")
        }
    }
}

#Preview {
    AnalyticsView()
}
