# iExpense - Expense Tracker iOS App

## Overview
iExpense is an iOS app developed using SwiftUI that helps users track their expenses and income. It allows users to record transactions, visualize their spending using charts, apply advanced filters, and manage their financial data efficiently.

## Features
1. **Transaction Tracking**: Users can record their expenses and income by adding transactions with details such as title, remarks, amount, date, and category.
2. **Visual Charts**: The app provides visual representation of transactions using eye-catching charts, allowing users to analyze their spending patterns over time.
3. **Advanced Filters**: Users can apply advanced filters to search and filter transactions based on various criteria, making it easy to find specific expenses.
4. **Tab Navigation**: The app uses a tab-based navigation system to provide easy access to different features such as recent transactions, search functionality, charts, and settings.
5. **User-Friendly Interface**: iExpense features a user-friendly interface with intuitive design and interactive elements, ensuring a seamless user experience.

## Components
### 1. Transaction Model
The `Transaction` model represents individual transactions recorded by the user. It contains properties such as title, remarks, amount, date, category, and tint color.

### 2. Views
- **MainTabBar**: The main view of the app containing tab-based navigation for different sections including recent transactions, search, charts, and settings.
- **RecentsView**: Displays recent transactions and provides options for filtering and categorizing transactions.
- **ChartsView**: Shows visual charts representing transaction data over time, allowing users to visualize their spending patterns.
- **SettingsView**: Allows users to customize app settings and preferences.
- **TransactionCardView**: Represents a card view for displaying transaction details in a list format.
- **IntroView**: Introduction screen displayed to users on their first launch, providing an overview of the app's features.

### 3. Extensions
- **View+Extensions**: Contains extensions for SwiftUI views, adding utility functions such as spacing adjustments, date formatting, and currency string conversion.
- **Date+Extensions**: Provides extensions for the `Date` class, including functions for obtaining the start and end of a month.

### 4. Additional Components
- **ChartGroup**: Represents a group of transactions for charting purposes, including the date, categories, total income, and total expense.
- **ChartCategory**: Represents a category within a chart group, containing the total value of the category.

## Usage
To use iExpense, simply install the app on your iOS device and follow the on-screen instructions to start recording your transactions. You can navigate between different sections using the tab bar at the bottom of the screen and utilize features such as transaction tracking, visual charts, advanced filters, and settings customization.

## Development
The app is developed using SwiftUI, a modern framework for building user interfaces across all Apple platforms. It leverages SwiftUI's declarative syntax, which simplifies the process of building complex UI components and ensures a consistent user experience across devices.

## Contributions
Contributions to iExpense are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request on GitHub.

## License
This project is licensed under the [MIT License](LICENSE).

---
