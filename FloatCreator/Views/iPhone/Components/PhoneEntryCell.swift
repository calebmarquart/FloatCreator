//
//  FloatCell.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct PhoneEntryCell: View {
    
    @AppStorage("show_images") private var showImages = true
    
    let title: String
    let type: MoneyType
    let multiplier: String
    let image: Image
    let system: Bool
    let imageWidth: CGFloat
    
    @Binding private var text: String
    @FocusState private var focus: MoneyType?
    
    init(type: MoneyType, text: Binding<String>, focus: FocusState<MoneyType?>) {
        
        self._text = Binding(projectedValue: text)
        self._focus = focus
        self.multiplier = type.multiplier()
        self.title = type.title()
        self.image = type.image()
        self.system = type.isSystem()
        self.imageWidth = type.imageWidth()
        self.type = type
    }
    
    var body: some View {
        HStack {
            if showImages {
                image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.primary).opacity(system ? 0.2 : 1)
                    .frame(height: imageWidth)
            }
            TextField(title, text: $text)
                .focused($focus, equals: type)
                .textField()
            Text("x \(multiplier) = ")
            Text(type.valueString(Int(text) ?? 0)).bold()
        }
        .keyboardType(.numberPad)
    }
}
