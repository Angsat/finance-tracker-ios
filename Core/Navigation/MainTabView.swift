//
//  MainTabView.swift
//  FinanceTracker
//
//  Created by Angsat on 22.05.2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            TransactionListView()
                .tabItem {

                    Label(
                        "Transactions",
                        systemImage: "list.bullet"
                    )
                }

            AnalyticsView()
                .tabItem {

                    Label(
                        "Analytics",
                        systemImage: "chart.pie.fill"
                    )
                }

            SettingsView()
                .tabItem {

                    Label(
                        "Settings",
                        systemImage: "gearshape.fill"
                    )
                }
        }
    }
}

#Preview {
    MainTabView()
}
