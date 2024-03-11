//
//  ChartsView.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI
import Charts
import SwiftData

// View for displaying charts
struct ChartsView: View {
    // Fetch transactions using SwiftData
    @Query(animation: .snappy) var transactions: [Transaction]
    // State variable to hold chart groups
    @State var chartGroups: [ChartGroup] = []
    
    // Body of the view
    var body: some View {
        NavigationStack{
            ZStack {
                Color.Neumorphic.main
                    .ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            // Title
                            Text("Charts")
                                .font(.custom("gilroy-semibold", size: 25))
                                .hSpacing(.leading)
                                .padding(.top)
                            // Chart view if transactions exist
                            if !transactions.isEmpty {
                                ChartView()
                                    .frame(height: 200)
                                    .padding(10)
                                    .padding(.top,10)
                                    .softOuterShadow()
                                    .cornerRadius(10)
                            }
                            else{
                                // Message if no transactions exist
                                VStack(spacing: 10.0) {
                                    Image("charts")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                    Text("No transactions")
                                        .font(.custom("gilroy-semibold", size: 25))
                                    Text("Add a new transaction to view the chart.")
                                        .font(.custom("gilroy-medium", size: 16))
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical, 140)
                            }
                            
                            // Display chart groups
                            ForEach(chartGroups){ group in
                                VStack(alignment: .leading, spacing: 10.0){
                                    
                                    Text(format(date:group.date, format:"MMM yyyy"))
                                        .font(.custom("gilroy-semibold", size: 18))
                                        .foregroundStyle(.primary)
                                        .hSpacing(.leading)
                                    
                                    NavigationLink {
                                        ListOfTransaction(month: group.date, transactions: transactions)
                                            .navigationBarBackButtonHidden()
                                        
                                    } label: {
                                        CardView(income: group.totalIncome, expense: group.totalExpense)
                                            .foregroundColor(.primary)
                                    }
                                    
                                }
                                .padding(.top)
                                
                            }
                            
                        }
                        .padding(.horizontal,24)
                        .padding(.bottom)
                        
                    }
                    .onAppear{
                        createChartGroup()} // Create chart groups when view appears
                    Rectangle()
                        .fill(Color.Neumorphic.main)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                }
                
            }
        }
    }
    
    // View for displaying charts
    @ViewBuilder
    func ChartView() -> some View{
        Chart{
            ForEach(chartGroups){ group in
                ForEach(group.categories){ chart in
                    BarMark(
                        x:.value("Month", format(date: group.date , format: "MMM yy")),
                        y:.value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom, alignment: .trailing)
        .chartForegroundStyleScale(range: [Color.brandGreen.gradient, Color.brandPurple.gradient])
    }
    
    // Function to create chart groups
    func createChartGroup(){
        Task.detached(priority: .high) {
            let calendar = Calendar.current
            
            let groupedByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)
                return components
            }
            let sortedGroups = groupedByDate.sorted{
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroups = sortedGroups.compactMap { dict-> ChartGroup? in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter({ $0.category == Category.income.rawValue})
                let expense = dict.value.filter({ $0.category == Category.expense.rawValue})
                
                let incomeTotalValue = total(income, category: .income)
                let expenseTotalValue = total(expense, category: .expense)
                
                return .init(date: date,
                             categories: [
                                .init(totalValue: incomeTotalValue, category: .income),
                                .init(totalValue: expenseTotalValue, category: .expense)
                             ],
                             totalIncome: incomeTotalValue,
                             totalExpense: expenseTotalValue)
            }
            
            await MainActor.run {
                self.chartGroups = chartGroups
            }
        }
    }
}

// View for displaying list of transactions for a specific month
struct ListOfTransaction: View {
    @Environment(\.dismiss) var dismiss
    var month : Date
    var transactions: [Transaction]
    var dateFilteredTransaction: [Transaction]{
        return transactions.filter({$0.dateAdded.startOfMonth == month.startOfMonth})
    }
    var body: some View {
        ZStack {
            Color.Neumorphic.main
                .ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack{
                        // Section for income transactions
                        Section{
                            ForEach(dateFilteredTransaction.filter({$0.category == Category.income.rawValue}), id: \.self){ transaction in
                                TransactionCard(transaction: transaction)
                            }
                        }header: {
                            Text("Income")
                                .font(.custom("gilroy-semibold", size: 18))
                                .foregroundStyle(.primary)
                                .hSpacing(.leading)
                                .padding([.leading, .top])
                        }
                        
                        // Section for expense transactions
                        Section{
                            ForEach(dateFilteredTransaction.filter({$0.category == Category.expense.rawValue}), id: \.self){ transaction in
                                TransactionCard(transaction: transaction)
                            }
                        }header: {
                            Text("Expense")
                                .font(.custom("gilroy-semibold", size: 18))
                                .foregroundStyle(.primary)
                                .hSpacing(.leading)
                                .padding([.leading, .top])
                        }
                        
                    }
                }
                .navigationTitle(format(date: month, format: "MMM yy"))
                Rectangle()
                    .fill(Color.Neumorphic.main)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            }
            
            
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.brandPurple)
                }
            }
        }
    }
}

// Preview for ChartsView
#Preview {
    ChartsView()
}
