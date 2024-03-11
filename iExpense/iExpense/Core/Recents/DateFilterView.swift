//
// DateFilterView.swift
// iExpense
//
// Created by Ashwin Kumar on 01/03/24.
//

import SwiftUI

// DateFilterView allows users to select a start and end date for filtering transactions
struct DateFilterView: View {
    @State var start: Date // Start date for filtering
    @State var end: Date // End date for filtering
    var onSubmit: (Date, Date) -> () // Closure to handle submission of selected dates
    var onClose: () -> () // Closure to handle closing the view
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main // Background color with Neumorphic effect
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack{
                    DateSelection(date: $start, title: "Start ") // Component to select start date
                        .padding(.bottom)
                    DateSelection(date: $end, title: "End ") // Component to select end date
                    
                    HStack() {
                        Button{
                            onClose() // Close the view when Cancel button is tapped
                        }label: {
                            Text("Cancel") // Text for Cancel button
                                .foregroundStyle(.gray) // Gray text color
                                .font(.custom("gilroy-semibold", size: 20)) // Custom font and size
                                .padding(.horizontal,40) // Horizontal padding
                        }
                        .softButtonStyle(.capsule, mainColor: Color.Neumorphic.main, pressedEffect: .hard) // Apply Neumorphic button style
                        
                        Spacer() // Flexible space to push other elements to the right
                        
                        Button{
                            onSubmit(start, end) // Submit selected dates when Filter button is tapped
                        }label: {
                            Text("Filter") // Text for Filter button
                                .foregroundStyle(.white) // White text color
                                .font(.custom("gilroy-semibold", size: 20)) // Custom font and size
                                .padding(.horizontal,40) // Horizontal padding
                        }
                        .softButtonStyle(.capsule, mainColor: Color(.brandPurple), pressedEffect: .flat) // Apply Neumorphic button style
                        
                    }
                    .padding(.horizontal,24) // Horizontal padding for buttons
                }
                .padding(.top, 15) // Top padding for the VStack
            }
            
        }
        .frame(height: 380) // Set fixed height for the view
        .vSpacing(.bottom) // Apply bottom vertical spacing
        
    }
}

