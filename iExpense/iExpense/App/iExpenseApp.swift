//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabBar()
                .modelContainer(for: [Transaction.self])
        }
    }
}
