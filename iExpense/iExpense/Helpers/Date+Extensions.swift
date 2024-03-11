//
// Date+Extensions.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import Foundation

// Extension for the Date struct, providing additional functionality.
extension Date {
    // Computed property to get the start date of the current month.
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self) // Extracts the year and month components from the date.
        return calendar.date(from: components) ?? self // Constructs and returns a new date using the extracted components.
    }
    
    // Computed property to get the end date of the current month.
    var endOfMonth: Date {
        let calendar = Calendar.current
        // Adds one month and subtracts one minute to get the end of the current month.
        return calendar.date(byAdding: .init(month: 1, minute: -1), to: self.startOfMonth) ?? self
    }
}
