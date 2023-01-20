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

struct KeyViewModifier: ViewModifier {
    
    let width: CGFloat
    let corner: CGFloat
    let font: CGFloat
    
    init(width: CGFloat) {
        self.width = width / 3 - 16
        self.corner = width / 30
        self.font = width / 10
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: font).bold())
            .frame(width: width, height: width)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(corner)
            .padding(8)
    }
}

struct ZeroKeyModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let corner: CGFloat
    let font: CGFloat
    
    init(width: CGFloat) {
        self.width = width / 3 - 16
        self.height = width / 3 * 2 - 16
        self.corner = width / 30
        self.font = width / 10
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: font).bold())
            .frame(width: width, height: height)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(corner)
            .padding(8)
    }
}

extension View {
    func keyView(width: CGFloat) -> some View {
        return modifier(KeyViewModifier(width: width))
    }
    
    func zeroKey(width: CGFloat) -> some View {
        return modifier(ZeroKeyModifier(width: width))
    }
    
    func textField() -> some View {
        modifier(ModernTextFieldStyle())
    }
    
    
}
