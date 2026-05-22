//
//  SettingsView.swift
//  FinanceTracker
//
//  Created by Angsat on 22.05.2026.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {

        NavigationStack {

            List {

                Section("Appearance") {

                    Text("Dark Mode")
                }

                Section("About") {

                    Text("Finance Tracker")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
