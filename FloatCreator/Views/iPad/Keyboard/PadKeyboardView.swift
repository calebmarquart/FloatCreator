//
//  PadKeyboardView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

struct PadKeyboardView: View {
    
    @Binding var isActive: Bool
    @Binding var isVisible: Bool
    @Binding var activeNumber: String
    
    let numbers: [[String]] = [
        ["1", "4", "7"],
        ["2","5","8"],
        ["3","6","9"]
    ]
    
    let width: CGFloat
    
    var body: some View {
            HStack(spacing: 0) {
                ForEach(numbers, id: \.self) { col in
                    VStack(spacing: 0) {
                        ForEach(col, id: \.self) { item in
                            Button {
                                activeNumber += item
                            } label: {
                                Text(item)
                                    .foregroundColor(.primary)
                                    .keyView(width: width)
                            }
                            .disabled(!isActive)
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    Button {
                        if !activeNumber.isEmpty {
                            activeNumber.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .keyView(width: width)
                    }
                    .disabled(!isActive)
                    
                    Button {
                        activeNumber += "0"
                    } label: {
                        Text("0")
                            .foregroundColor(.primary)
                            .zeroKey(width: width)
                    }
                    .disabled(!isActive)
                }
            }
            .padding()
            .background(Color("textfield"))
        
    }
}

struct PadKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PadKeyboardView(isActive: .constant(true), isVisible: .constant(true), activeNumber: .constant(""), width: 300)
        }
        
        .padding()
        
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
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
