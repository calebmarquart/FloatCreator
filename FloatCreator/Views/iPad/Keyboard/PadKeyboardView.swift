//
//  PadKeyboardView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

struct PadKeyboardView: View {
    
    @Binding var isActive: Bool
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
                    .tint(Color("accent"))
                    
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
            PadKeyboardView(isActive: .constant(true), activeNumber: .constant(""), width: 300)
        }
        .padding()
        
    }
}
