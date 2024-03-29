//
//  DisplayPhoneCellView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct DisplayPhoneCellView: View {
    
    @AppStorage("show_images") private var showImages = true
    
    let type: MoneyType
    let title: String
    let image: Image
    let imageWidth: CGFloat
    let amount: Int
    
    init(type: MoneyType, amount: Int) {
        self.type = type
        self.amount = amount
        
        self.title = type.title()
        self.image = type.image()
        self.imageWidth = type.imageWidth() - 5
    }
    
    
    var body: some View {
        HStack {
            if showImages {
                image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(type.isSystem() ? .secondary : .primary)
                    .frame(height: imageWidth)
            }
            
            Text(title)
            Spacer()
            Text("\(amount) - ")
            Text("$" + type.valueString(amount)).bold()
        }
    }
}
