//
//  NewTransactionView.swift
//  iExpense
//
//  Created by Ashwin Kumar on 02/03/24.
//

import SwiftUI
import SwiftData

// View for adding or editing a transaction
struct NewTransactionView: View {
    // Environment objects and state variables
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State var title = ""
    @State var remarks = ""
    @State var amount: Double = .zero
    @State var date: Date = .now
    @State var category: Category = .expense
    @State var tint: TintColor = tints.randomElement()!
    @State var showAlert = false
    var editTransaction: Transaction?
    
    // Body of the view
    var body: some View {
        ZStack {
            Color.Neumorphic.main
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                // Title and close button
                HStack {
                    Text(editTransaction != nil ? "Edit transaction": "Add transaction")
                        .font(.custom("gilroy-semibold", size: 25))
                    Spacer()
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.subheadline.bold())
                            .foregroundStyle(.primary)
                    }
                    .softButtonStyle(.circle)
                }
                .padding(.horizontal,24)
                .padding(.vertical)
                // Main content
                ScrollView(.vertical, showsIndicators: false) {
                    CategoryTab(selectedCategory: $category) // Select category
                    TextInputView(heading: "Title", text: $title) // Title input
                    TextInputView(heading: "Remarks", text: $remarks) // Remarks input
                    AmountInputView(amount: $amount, category: $category) // Amount input
                    DateSelection(date: $date, title: "") // Date selection
                    
                    // Buttons for delete and save
                    HStack() {
                        Button{
                            if editTransaction != nil {
                                showAlert.toggle()
                            }
                        }label: {
                            Text("Delete")
                                .foregroundStyle(.red)
                                .font(.custom("gilroy-semibold", size: 20))
                                .padding(.horizontal,40)
                        }
                        .softButtonStyle(.capsule, mainColor: Color.Neumorphic.main, pressedEffect: .hard)
                        Spacer()
                        Button{
                            save()
                        }label: {
                            Text("Save")
                                .foregroundStyle(.white)
                                .font(.custom("gilroy-semibold", size: 20))
                                .padding(.horizontal,40)
                        }
                        .softButtonStyle(.capsule, mainColor: Color(.brandPurple), pressedEffect: .flat)
                    }
                    .padding(.horizontal,24)
                    .padding(.vertical)
                }
                // Separator
                if editTransaction != nil{
                    Rectangle()
                        .fill(Color.Neumorphic.main)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                }
            }
        }
        // On Appear, populate fields if editing
        .onAppear(perform: {
            if let editTransaction{
                title = editTransaction.title
                remarks = editTransaction.remarks
                date = editTransaction.dateAdded
                amount = editTransaction.amount
                if let category = editTransaction.rawCategory{
                    self.category = category
                }
                title = editTransaction.title
                if let tint = editTransaction.tint{
                    self.tint = tint
                }
            }
        })
        // Alert for deletion confirmation
        .alert("Delete",isPresented: $showAlert) {
            Button("Cancel", role: .cancel){}
            Button("Delete", role: .destructive){
                delete()
            }
        }message: {
            Text("Do you want to delete this transaction?")
        }
    }
    
    // Function to save transaction
    func save(){
        if editTransaction != nil{
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateAdded = date
        }else{
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: date, category: category, tintColor: tint)
            modelContext.insert(transaction)
        }
        dismiss()
    }
    
    // Function to delete transaction
    func delete(){
        modelContext.delete(editTransaction!)
        dismiss()
    }
}

// View for text input
struct TextInputView: View {
    var heading: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.custom("gilroy-semibold", size: 18))
                .foregroundColor(.brandPurple)
            TextField("Enter \(heading)..", text: $text)
                .foregroundColor(.primary)
                .font(.custom("gilroy-semibold", size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 30), radius: 1)
                )
            
        }
        .padding(.horizontal,24)
        .padding(.vertical)
    }
}

// View for amount input
struct AmountInputView: View {
    @Binding var amount: Double
    @Binding var category: Category
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount")
                .font(.custom("gilroy-semibold", size: 18))
                .foregroundColor(.brandPurple)
            TextField("₹0.00", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                .keyboardType(.decimalPad)
                .foregroundColor(category == .income ? .green : .red)
                .font(.custom("gilroy-semibold", size: 25))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 30), radius: 1)
                )
            
        }
        .padding(.horizontal,24)
        .padding(.vertical)
    }
}

// View for date selection
struct DateSelection: View {
    @Binding var date: Date
    var title: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title)Date")
                .font(.custom("gilroy-semibold", size: 18))
                .foregroundColor(.brandPurple)
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(.brandPurple)
                .padding(.horizontal)
                .softOuterShadow()
                .background{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.Neumorphic.main)
                }
        }
        .padding(.horizontal,24)
    }
}
