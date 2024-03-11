//
// CardView.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI
import SwiftData

// CardView displays the total balance, income, and expense
struct CardView: View {
    var income: Double // Total income
    var expense: Double // Total expense
    
    var body: some View {
        ZStack{
            Color.Neumorphic.main // Background color with Neumorphic effect
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.Neumorphic.main) // Rounded rectangle with Neumorphic effect
                .frame(maxWidth: .infinity, maxHeight: 150)
                .softOuterShadow() // Apply soft outer shadow
            
            HStack {
                VStack(alignment: .leading, spacing: 10.0){
                    Text("Total balance") // Text indicating total balance
                        .font(.custom("gilroy-medium", size: 18))
                        .foregroundStyle(.gray) // Gray color
                    Text(income - expense, format: .currency(code: "Inr")) // Display total balance
                        .font(.custom("gilroy-semibold", size: 25)) // Bold font
                }
                Spacer() // Spacer to push other elements to the right
                
                // Display income and expense
                VStack(alignment: .leading, spacing: 20){
                    ExpenseCard(category: .income, amount: income) // Display income
                    ExpenseCard(category: .expense, amount: expense) // Display expense
                }
                .padding(.vertical) // Add vertical padding
                
            }
            .padding(.horizontal) // Add horizontal padding
            
        }
    }
}

// Preview for CardView
#Preview {
    CardView(income: 100, expense: 500) // Example usage with income and expense amounts
}
