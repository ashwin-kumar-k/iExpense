//
// TransactionCardView.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI

// TransactionCardView displays information about a transaction
struct TransactionCardView: View {
    var transaction: Transaction // Transaction object
    
    var body: some View {
        HStack(spacing: 12.0){
            // Display transaction title's first character as a circle with background color from transaction color
            Text(transaction.title.prefix(1))
                .font(.title) // Title font size
                .fontWeight(.semibold) // Bold font weight
                .foregroundStyle(.white) // White text color
                .frame(width: 45, height: 45) // Fixed frame size
                .background(transaction.color.gradient.opacity(0.8), in: .circle) // Background color with opacity
            
            VStack(alignment: .leading, spacing: 4.0){
                Text(transaction.title) // Display transaction title
                    .font(.headline) // Headline font size
                    .foregroundStyle(.primary) // Primary text color
                
                Text(transaction.remarks) // Display transaction remarks
                    .font(.caption) // Caption font size
                    .foregroundStyle(.secondary) // Secondary text color
                
                Text(format(date: transaction.dateAdded, format: "dd MMM yyyy")) // Display formatted transaction date
                    .font(.caption2) // Caption 2 font size
                    .foregroundStyle(.gray) // Gray text color
            }
            
            Spacer() // Flexible space to push other elements to the right
            
            // Display transaction amount with currency code "INR" and color based on transaction category
            Text(transaction.amount, format: .currency(code: "INR"))
                .fontWeight(.semibold) // Semibold font weight
                .foregroundStyle(transaction.category == "Income" ? .green : .red) // Green for income, red for expense
        }
    }
}

// Preview for TransactionCardView
#Preview {
    TransactionCardView(transaction: sampleTransactions[1]) // Example usage with a sample transaction
}
