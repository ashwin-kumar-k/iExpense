//
// ContentView.swift
// iExpense
//
// Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI

// MainTabBar is the main entry point of the application, containing the tab navigation.
struct MainTabBar: View {
    @State var selectedTab: TabIcons = .home // Current selected tab
    @AppStorage("isFirstTime") var isFirstTime: Bool = true // App storage for first-time launch
    
    // Hide the system's default tab bar appearance
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selectedTab ,
                content:  {
            RecentsView() // Recent transactions view
                .tag(TabIcons.home) // Tag for home tab
            SearchView() // Search transactions view
                .tag(TabIcons.search) // Tag for search tab
            ChartsView() // Charts view
                .tag(TabIcons.charts) // Tag for charts tab
            SettingsView() // Settings view
                .tag(TabIcons.settings) // Tag for settings tab
        })
        .overlay{
            TabBarView(selectedTab: $selectedTab) // Overlay the custom tab bar
        }
        .sheet(isPresented: $isFirstTime, content: {
            IntroView() // Present intro view as a sheet on first launch
                .interactiveDismissDisabled() // Disable interactive dismiss for intro view
        })
    }
}

// Preview for the MainTabBar
#Preview {
    MainTabBar()
}

// TabBarView represents the custom tab bar at the bottom of the screen.
struct TabBarView: View {
    @Binding var selectedTab: TabIcons // Binding for the selected tab
    @Namespace var animation // Namespace for animations
    
    var body: some View {
        VStack(spacing: 0.0){
            Spacer()
            HStack{
                // Iterate through all tab icons and display them in the tab bar
                ForEach(TabIcons.allCases, id: \.self){ item in
                    Image(systemName: item.image) // Tab icon
                        .font(.subheadline.bold()) // Font styling
                        .frame(width: 50, height: 50) // Size
                        .foregroundStyle(selectedTab == item ? .white : .gray) // Text color based on selection
                        .background{
                            if item == selectedTab {
                                // Apply a background when the tab is selected
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(.brandPurple).softOuterShadow()
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation) // Matched geometry effect for animation
                            }
                        }
                        .onTapGesture {
                            withAnimation(.snappy) { selectedTab = item } // Update selected tab with animation
                        }
                }
                .padding(.horizontal) // Horizontal padding for tab items
            }
            .frame(maxWidth: .infinity, minHeight:70) // Frame styling
            .background{
                RoundedRectangle(cornerRadius: 50).fill(Color.Neumorphic.main) // Background styling
                    .softInnerShadow(RoundedRectangle(cornerRadius: 50), radius: 1) // Neumorphic effect
            }
            .padding(.horizontal, 24) // Horizontal padding for the entire tab bar
            .padding(.bottom) // Bottom padding for the tab bar
        }
        .ignoresSafeArea() // Ignore safe area insets
    }
}

// Enumeration representing different tab icons
enum TabIcons: String, CaseIterable{
    case home = "Home" // Home tab
    case search = "Search" // Search tab
    case charts = "Charts" // Charts tab
    case settings = "Settings" // Settings tab
    
    // Get the corresponding SF Symbol name for each tab icon
    var image: String{
        switch self {
            case .home:
                return "house"
            case .search:
                return "magnifyingglass"
            case .charts:
                return "chart.bar.xaxis"
            case .settings:
                return "gearshape"
        }
    }
}
