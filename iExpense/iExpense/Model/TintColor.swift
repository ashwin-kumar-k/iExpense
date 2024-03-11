//
//  TintColor.swift
//  iExpense
//
//  Created by Ashwin Kumar on 29/02/24.
//

import Foundation
import SwiftUI
struct TintColor: Identifiable{
    let id: UUID = .init()
    
    var color: String
    var value: Color
    
    
}
var tints: [TintColor] = [.init(color: "Red", value: .red),
                          .init(color: "Blue", value: .blue),
                          .init(color: "Green", value: .green),
                          .init(color: "Gray", value: .gray),
                          .init(color: "Yellow", value: .yellow),
                          .init(color: "Pink", value: .pink),
                          .init(color: "Orange", value: .orange),
                          .init(color: "Purple", value: .purple),
                          .init(color: "Indigo", value: .indigo)
]
