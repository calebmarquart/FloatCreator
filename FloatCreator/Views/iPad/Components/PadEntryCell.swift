//
//  PadEntryCell.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

struct PadEntryCell: View {
    
    @AppStorage("show_images") private var showImages = true
    
    @Binding var text: String
    @Binding var activeEntry: MoneyType?
    
    let title: String
    let type: MoneyType
    let image: Image
    let value: String
    let system: Bool
    let imageWidth: CGFloat
    
    init(type: MoneyType, text: Binding<String>, activeEntry: Binding<MoneyType?>) {
        self._text = Binding(projectedValue: text)
        self._activeEntry = Binding(projectedValue: activeEntry)
        
        self.image = type.image()
        self.title = type.title()
        self.value = type.multiplier()
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
            Text(text == "" ? title : text)
                .foregroundColor(text == "" ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textField()
                    .overlay {
                        if let activeEntry = activeEntry {
                            if activeEntry == type {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 3)
                                    .fill(Color("accent"))
                            }
                        }
                    }
            
            Text("x \(value) = ")
            Text(type.valueString(Int(text) ?? 0)).bold()
        }
        .onTapGesture {
            if activeEntry != type {
                activeEntry = type
            } else {
                activeEntry = nil
            }
        }
    }
}

struct PadEntryCell_Previews: PreviewProvider {
    static var previews: some View {
        PadEntryCell(type: .five, text: .constant(""), activeEntry: .constant(nil))
    }
}
