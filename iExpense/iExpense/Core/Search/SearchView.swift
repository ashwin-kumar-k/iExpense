//
//  SearchView.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI
import SwiftData

// View for searching transactions
struct SearchView: View {
    // State variable for search text
    @State var searchText:String = ""
    // Query to fetch transactions
    @Query var transactions : [Transaction]
    // Filtered transactions based on search text
    var filteredTransactions: [Transaction]{
        return transactions.filter({$0.title.localizedStandardContains(searchText) || $0.remarks.localizedStandardContains(searchText)})
    }
    
    // Body of the view
    var body: some View {
        NavigationStack {
            ZStack{
                Color.Neumorphic.main
                    .ignoresSafeArea()
                VStack{
                    // Title
                    Text("Search transactions")
                        .font(.custom("gilroy-semibold", size: 25))
                        .hSpacing(.leading)
                        .padding(.leading,24)
                        .padding(.top)
                    // Search input field
                    ScrollView(.vertical, showsIndicators: false){
                        SearchTextInput(searchText: $searchText)
                            .padding(.horizontal,24)
                            .padding(.vertical)
                        
                        // Display filtered transactions
                        VStack(spacing: 10.0) {
                            ForEach(filteredTransactions){ transaction in
                                NavigationLink(value: transaction) {
                                    TransactionCard(transaction: transaction)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    // Separator
                    Rectangle()
                        .fill(Color.Neumorphic.main)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                }
                // Overlay for displaying no results message
                .overlay {
                    if filteredTransactions.isEmpty{
                        VStack(spacing: 10.0) {
                            Image("search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .foregroundStyle(.brandPurple)
                            Text("No Results")
                                .font(.custom("gilroy-semibold", size: 25))
                            Text("Check the spelling or try a new search.")
                                .font(.custom("gilroy-regular", size: 16))
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            // Navigation destination to transaction detail view
            .navigationDestination(for: Transaction.self) { transaction in
                NewTransactionView(editTransaction: transaction)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

// Preview for SearchView
#Preview {
    SearchView()
}

// View for search text input
struct SearchTextInput: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.primary).font(Font.body.weight(.bold))
            TextField("Search...", text: $searchText)
                .foregroundColor(.primary)
                .font(.custom("gilroy-semibold", size: 18))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), radius: 1)
        )
    }
}
