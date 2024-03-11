//
// Transaction.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import Foundation
import SwiftUI
import SwiftData

// Transaction class representing a financial transaction.
@Model
class Transaction: Hashable {
    
    // Properties representing transaction details.
    var title: String // Title of the transaction.
    var remarks: String // Remarks or description of the transaction.
    var amount: Double // Amount of the transaction.
    var dateAdded: Date // Date when the transaction was added.
    var category: String // Category of the transaction (income or expense).
    var tintColor: String // Tint color representing the category.
    
    // Initialize a new transaction with provided details.
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue // Convert Category enum to raw string value.
        self.tintColor = tintColor.color // Use the tint color string representation.
    }
    
    // Computed property to get the color associated with the tint.
    @Transient
    var color: Color {
        // Retrieve the color from the tints array based on the tint color.
        return tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    // Computed property to get the TintColor object associated with the tint.
    @Transient
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor }) // Retrieve the tint from the tints array.
    }
    
    // Computed property to get the Category enum from the raw string value.
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue }) // Retrieve the Category enum.
    }
    
}

// Sample transaction data for demonstration purposes.
var sampleTransactions: [Transaction] = [
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 13999, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Apple Music", remarks: "Subscription", amount: 999, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "iCloud+", remarks: "Subscription", amount: 499, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Netflix", remarks: "Subscription", amount: 1299, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Payment", remarks: "Payment Received", amount: 5000, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
    .init(title: "Salary", remarks: "Credited to Bank", amount: 100000, dateAdded: .now, category: .income, tintColor: tints.randomElement()!)
]
