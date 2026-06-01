//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Angsat on 15.05.2026.
//

import SwiftUI
import SwiftData

@main
struct FinanceTrackerApp: App {
    private var selectedColorScheme: ColorScheme? {

        switch appTheme {

        case AppTheme.light.rawValue:
            return .light

        case AppTheme.dark.rawValue:
            return .dark

        default:
            return nil
        }
    }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Transaction.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @AppStorage("appTheme")
    private var appTheme = AppTheme.system.rawValue
    var body: some Scene {
        WindowGroup {

            MainTabView()
                .preferredColorScheme(
                    selectedColorScheme
                )
        }
        .modelContainer(sharedModelContainer)
    }
}
