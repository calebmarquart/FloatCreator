//
//  CoinsGroupView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct CoinsGroupView: View {
    let cash: Cash
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Coins").bold().padding(.horizontal).padding(.top)
            
            DisplayPadCellView(type: .nickels, amount: cash.nickels)
            DisplayPadCellView(type: .dimes, amount: cash.dimes)
            DisplayPadCellView(type: .quarters, amount: cash.quarters)
            DisplayPadCellView(type: .loonies, amount: cash.loonies)
            DisplayPadCellView(type: .toonies, amount: cash.toonies)
            
            HStack {
                Text("Coin Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getRollTotal(cash), specifier: "%.2f")")
            }
            .font(.subheadline)
            .padding(.horizontal)
        }
    }
}

struct CoinsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsGroupView(cash: emptyCash)
    }
}
