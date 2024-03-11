//
//  RecentsView.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI
import SwiftData
import Neumorphic

// View for displaying recent transactions
struct RecentsView: View {
    // App storage for username
    @AppStorage("username") var username = ""
    // Environment variable for model context
    @Environment(\.modelContext) var modelContext
    // Fetch transactions sorted by date in reverse order
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) var transactions : [Transaction]
    // State variables for date range selection, category filter, and more
    @State var startDate : Date = .now.startOfMonth
    @State var endDate : Date = .now.endOfMonth
    @State var selectedCategory: Category = .income
    @State private var showDateFilter = false
    @State var addNewTransaction = false
    @Namespace var animation
    // Computed property to calculate total income
    var income: Double {
        total(dateFilteredTransaction, category: .income)
    }
    // Computed property to calculate total expense
    var expense: Double {
        total(dateFilteredTransaction, category: .expense)
    }
    // Filtered transactions based on selected date range
    var dateFilteredTransaction: [Transaction] {
        return transactions.filter({$0.dateAdded >= startDate && $0.dateAdded <= endDate})
    }
    
    // Body of the view
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Neumorphic.main
                    .ignoresSafeArea()
                VStack {
                    // Header view containing greeting and add new transaction button
                    Header(showNewTransaction: $addNewTransaction, username: username)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        // Total balance card
                        TotalBalanceCard(totalBalance: income - expense)
                        
                        // Income and expense cards
                        HStack {
                            ExpenseCard(category: .income, amount: income)
                            Spacer()
                            ExpenseCard(category: .expense, amount: expense)
                        }
                        .padding(.horizontal,24)
                        
                        // Category tab for filtering transactions
                        CategoryTab(selectedCategory: $selectedCategory)
                        
                        // Filter header to toggle date filter
                        FilterHeader(showDateFilter: $showDateFilter)
                        
                        // List of transactions
                        if !dateFilteredTransaction.isEmpty {
                            VStack(spacing: 10.0) {
                                ForEach(dateFilteredTransaction.filter({$0.category == selectedCategory.rawValue})) { transaction in
                                    NavigationLink(destination: TransactionCard(transaction: transaction)) {
                                        TransactionCard(transaction: transaction)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                        } else {
                            // Message when there are no transactions
                            VStack {
                                Image("transaction")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                
                                Text("No transactions to show")
                                    .font(.custom("gilroy-medium", size: 16))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 20)
                        }
                    }
                    Rectangle()
                        .fill(Color.Neumorphic.main)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                }
            }
            // Full screen cover for adding new transaction
            .fullScreenCover(isPresented: $addNewTransaction) {
                NewTransactionView()
            }
            // Navigation destination for editing a transaction
            .navigationDestination(for: Transaction.self) { transaction in
                NewTransactionView(editTransaction: transaction)
                    .navigationBarBackButtonHidden()
            }
            // Sheet for date filter
            .sheet(isPresented: $showDateFilter) {
                DateFilterView(start: startDate, end: endDate) { start, end in
                    startDate = start
                    endDate = end
                    showDateFilter = false
                } onClose: {
                    showDateFilter = false
                }
                .presentationDetents([.height(380)])
            }
        }
    }
}

// Header view
struct Header: View {
    @Binding var showNewTransaction: Bool
    var username: String
    var body: some View {
        HStack {
            // Greeting message and username
            VStack(alignment: .leading, spacing: 5){
                Text("Hello,")
                    .font(.custom("gilroy-medium", size: 18))
                    .foregroundStyle(.gray)
                + Text(" \(!username.isEmpty ? username : "User")")
                    .font(.custom("gilroy-medium", size: 18))
                    .foregroundStyle(.brandPurple)
                Text("Welcome back")
                    .font(.custom("gilroy-semiBold", size: 20))
            }
            Spacer()
            // Button to add new transaction
            Button {
                showNewTransaction.toggle()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.primary)
            }
            .softButtonStyle(.circle)
        }
        .padding(.horizontal,24)
        .padding(.top,20)
    }
}

// Total balance card
struct TotalBalanceCard: View {
    var totalBalance : Double
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10.0){
                Text("Total balance")
                    .font(.custom("gilroy-medium", size: 18))
                    .foregroundStyle(.gray)
                Text(totalBalance, format: .currency(code: "Inr"))
                    .font(.custom("gilroy-Bold", size: 35))
            }
            Spacer()
            // Icon indicating increase or decrease in balance
            Image(totalBalance < 0 ? "decrease" :"Increase")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .softOuterShadow()
        }
        .padding(.horizontal,24)
        .padding(.vertical)
    }
}

// Income or Expense card
struct ExpenseCard: View {
    var category : Category
    var amount: Double
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10.0){
                Text("\(category.rawValue)")
                    .font(.custom("gilroy-Medium", size: 18))
                    .foregroundStyle(.gray)
                Text(amount, format: .currency(code: "Inr"))
                    .font(.custom("gilroy-Bold", size: 20))
                    .foregroundStyle(category == .income ? .green : .red)
            }
        }
    }
}

// Category tab for filtering transactions
struct CategoryTab: View {
    @Binding var selectedCategory : Category
    @Namespace var animation
    var body: some View {
        HStack(spacing: 20.0){
            ForEach(Category.allCases, id: \.self){ item in
                Text("\(item.rawValue)")
                    .font(.custom("gilroy-semibold", size: 18))
                    .foregroundStyle(selectedCategory == item ? .white : .gray)
                    .frame(maxWidth: .infinity,minHeight: 40)
                    .background{
                        if item == selectedCategory{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.brandPurple)
                                .softOuterShadow()
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = item
                        }
                        
                    }
            }
        }
        .frame(maxWidth: .infinity, minHeight:50)
        .background{
            RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), radius: 1)
        }
        .padding(.horizontal,24)
        .padding(.vertical)
    }
}

// Filter header to toggle date filter
struct FilterHeader: View {
    @Binding var showDateFilter : Bool
    var body: some View {
        HStack{
            Text("Transactions")
                .font(.custom("gilroy-semibold", size: 20))
            Spacer()
            Button(action: {showDateFilter.toggle()}) {
                Image(systemName: "line.3.horizontal.decrease")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .font(.footnote)
            }.softButtonStyle(.circle, mainColor: Color.Neumorphic.main, pressedEffect: .hard)
        }
        .padding(.horizontal,24)
    }
}

// Transaction card
struct TransactionCard: View {
    var transaction: Transaction
    var body: some View {
        HStack(spacing: 20.0){
            ZStack {
                Circle()
                    .fill(Color.Neumorphic.main).softOuterShadow()
                    .frame(width: 50, height: 50)
                
                Text(transaction.title.prefix(1))
                    .font(.custom("gilroy-bold", size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient.opacity(0.8), in: .circle)
            }
            
            VStack(alignment: .leading, spacing: 8.0){
                Text(transaction.title)
                    .font(.custom("gilroy-semibold", size: 16))
                Text(transaction.remarks)
                    .font(.custom("gilroy-regular", size: 13))
                    .foregroundStyle(.primary)
                Text(format(date:transaction.dateAdded,format:"dd MMM yy"))
                    .font(.custom("gilroy-regular", size: 10))
                    .foregroundStyle(.primary)
            }
            Spacer()
            Text(transaction.amount, format: .currency(code: "Inr"))
                .font(.custom("gilroy-Bold", size: 16))
                .foregroundStyle(transaction.category == "Income" ? .green : .red)
        }
        .padding(.horizontal,24)
        .padding(.vertical)
    }
}

// Preview for RecentsView
#Preview {
    RecentsView()
}

