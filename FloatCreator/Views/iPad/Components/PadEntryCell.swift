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
       
        var system: Bool = false
        
        self._text = Binding(projectedValue: text)
        self._activeEntry = Binding(projectedValue: activeEntry)
        
        switch type {
        case .five:
            title = "$5 Bills"
            image = Image("5")
            value = "5"
        case .ten:
            title = "$10 Bills"
            image = Image("10")
            value = "10"
        case .twenty:
            title = "$20 Bills"
            image = Image("20")
            value = "20"
        case .fifty:
            title = "$50 Bills"
            image = Image("50")
            value = "50"
        case .hundred:
            title = "$100 Bills"
            image = Image("100")
            value = "100"
        case .rollNickels:
            title = "Roll of Nickels"
            image = Image(systemName: "n.circle")
            system = true
            value = "2"
        case .rollDimes:
            title = "Roll of Dimes"
            image = Image(systemName: "d.circle")
            system = true
            value = "5"
        case .rollQuarters:
            title = "Roll of Quarters"
            image = Image(systemName: "q.circle")
            system = true
            value = "10"
        case .rollLoonies:
            title = "Roll of Loonies"
            image = Image(systemName: "l.circle")
            system = true
            value = "25"
        case .rollToonies:
            title = "Roll of Toonies"
            image = Image(systemName: "t.circle")
            system = true
            value = "50"
        case .nickels:
            title = "Nickels"
            image = Image("nickel")
            value = "0.05"
        case .dimes:
            title = "Dimes"
            image = Image("dime")
            value = "0.10"
        case .quarters:
            title = "Quarters"
            image = Image("quarter")
            value = "0.25"
        case .loonies:
            title = "Loonies"
            image = Image("loonie")
            value = "1.00"
        case .toonies:
            title = "Toonies"
            image = Image("toonie")
            value = "2.00"
        }
        
        self.type = type
        self.system = system
        
        self.imageWidth = type.imageWidth()
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
                                    .fill(Color.blue)
                            }
                        }
                    }
            
            Text("x \(value) = ")
            Text((Int(text) ?? 0).valueString(type))
                .bold()
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
