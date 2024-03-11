//
//  ChartModel.swift
//  iExpense
//
//  Created by Ashwin Kumar on 03/03/24.
//

import Foundation

//
// ChartGroup.swift
//

import Foundation

// Structure representing a group of transactions for charting purposes.
struct ChartGroup: Identifiable {
    let id = UUID() // Unique identifier for the chart group.
    var date: Date // Date associated with the chart group.
    var categories: [ChartCategory] // Categories and their total values within the chart group.
    var totalIncome: Double // Total income within the chart group.
    var totalExpense: Double // Total expense within the chart group.
}

// Structure representing a category within a chart group.
struct ChartCategory: Identifiable {
    let id = UUID() // Unique identifier for the chart category.
    var totalValue: Double // Total value of the category within the chart group.
    var category: Category // Category of the transaction.
}
