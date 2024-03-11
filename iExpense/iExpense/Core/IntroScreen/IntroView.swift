//
// IntroView.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI

// IntroView displays introductory information about the Expense Tracker app.
struct IntroView: View {
    @AppStorage("isFirstTime") var isFirstTime: Bool = true // App storage for first-time launch
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main // Background color
                .ignoresSafeArea() // Ignore safe area insets
            
            VStack{
                Text("What's new in the Expense Tracker!") // Title
                    .font(.custom("gilroy-Bold", size: 35)) // Font styling
                    .multilineTextAlignment(.center) // Text alignment
                    .padding(.top, 65) // Top padding
                    .padding(.bottom,25) // Bottom padding
                
                VStack(alignment: .leading, spacing: 25.0){
                    PointsView(symbol: "transaction", title: "Transactions", subtitle: "Keep track of your earnings and expenses.") // Transaction point
                    
                    PointsView(symbol: "charts", title: "Visual Charts", subtitle: "View your transaction using eye-catching graphic representation.") // Charts point
                    
                    PointsView(symbol: "search", title: "Advance filters", subtitle: "Find the expenses you want by advance search and filtering.") // Advance filters point
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Frame styling
                .padding(.horizontal, 15) // Horizontal padding
                
                Spacer(minLength: 10) // Spacer
                
                Button{
                    isFirstTime = false // Update isFirstTime to false when Continue button is tapped
                }label: {
                    Text("Continue") // Continue button text
                        .font(.custom("gilroy-Bold", size: 20)) // Font styling
                        .foregroundStyle(.white) // Text color
                        .frame(maxWidth: .infinity) // Take full width
                        .contentShape(.rect) // Content shape
                }
                .softButtonStyle(.capsule, mainColor: .brandPurple , pressedEffect: .flat) // Button styling
            }
            .padding(15) // Outer padding
        }
    }
}

// Preview for IntroView
#Preview {
    IntroView()
}

// PointsView represents a single point in the introductory information.
struct PointsView: View {
    var symbol: String // Symbol image name
    var title: String // Point title
    var subtitle: String // Point subtitle
    
    var body: some View {
        HStack(spacing: 10.0){ // Horizontal stack
            Image(symbol) // Symbol image
                .resizable() // Resizable
                .scaledToFit() // Scale to fit
                .foregroundColor(.blue) // Symbol color
                .frame(width: 80) // Size
                .softOuterShadow() // Outer shadow
            
            VStack(alignment: .leading, spacing: 6.0){ // Vertical stack
                Text(title) // Title
                    .font(.custom("gilroy-Semibold", size: 21)) // Font styling
                Text(subtitle) // Subtitle
                    .font(.custom("gilroy-regular", size: 16)) // Font styling
                    .foregroundStyle(.gray) // Text color
            }
        }
        .padding(.vertical) // Vertical padding
    }
}
