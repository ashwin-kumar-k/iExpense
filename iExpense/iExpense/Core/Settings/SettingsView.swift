//
//  SettingsView.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("username") var username = ""
    @AppStorage("isAppLockEnabled") var isAppLockEnabled = false
    @AppStorage("lockWhenAppGoesBackground") var lockWhenAppGoesBackground = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.Neumorphic.main
                    .ignoresSafeArea()
                VStack{
                    Text("Settings")
                        .font(.custom("gilroy-semibold", size: 25))
                        .hSpacing(.leading)
                        .padding(.leading,24)
                        .padding(.top)
                    TextInputView(heading: "User name", text: $username)
                }
                .vSpacing(.top)
            }
            
        }
    }
}

#Preview {
    SettingsView()
}
