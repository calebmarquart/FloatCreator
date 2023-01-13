//
//  RollsGroupView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct RollsGroupView: View {
    let cash: Cash
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rolls").bold().padding(.horizontal).padding(.top)
            
            DisplayPadCellView(type: .rollNickels, amount: cash.rollNickels)
            DisplayPadCellView(type: .rollDimes, amount: cash.rollDimes)
            DisplayPadCellView(type: .rollQuarters, amount: cash.rollQuarters)
            DisplayPadCellView(type: .rollLoonies, amount: cash.rollLoonies)
            DisplayPadCellView(type: .rollToonies, amount: cash.rollToonies)
            
            HStack {
                Text("Roll Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getRollTotal(cash))")
            }
            .font(.subheadline)
            .padding(.horizontal)
        }
    }
}

struct RollsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RollsGroupView(cash: emptyCash)
    }
}
