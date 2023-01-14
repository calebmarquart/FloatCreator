//
//  ViewModifiers.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct ModernTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.1), radius: 3, x: 3, y: 3)
    }
}

extension View {
    func textField() -> some View {
        modifier(ModernTextFieldStyle())
    }
}
