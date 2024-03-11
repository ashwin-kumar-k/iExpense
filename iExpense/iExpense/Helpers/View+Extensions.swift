//
// View+Extensions.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import Foundation
import SwiftUI

// Extension for the View protocol, providing various convenience methods.
extension View {
    // Method to add horizontal spacing to the view.
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment) // Adjusts the view's width to fill the available space.
    }
    
    // Method to add vertical spacing to the view.
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment) // Adjusts the view's height to fill the available space.
    }
    
    // Method to format a date into a string with a specified format.
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format // Sets the date format
        return formatter.string(from: date) // Formats the date into a string using the specified format.
    }
    
    // Method to convert a double value into a formatted currency string.
    func currencySring(_ value: Double, allowedDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // Sets the number style to currency format.
        formatter.maximumFractionDigits = allowedDigits // Sets the maximum number of fraction digits.
        return formatter.string(from: .init(value: value)) ?? "" // Converts the double value to a currency string.
    }
    
    // Method to calculate the total amount for a given category from an array of transactions.
    func total(_ transactions: [Transaction], category: Category) -> Double {
        return transactions.filter({ $0.category == category.rawValue }) // Filters transactions by category.
            .reduce(Double.zero) { partialResult, Transaction in // Reduces the filtered transactions to get the total amount.
                partialResult + Transaction.amount // Accumulates the total amount.
            }
    }
}
