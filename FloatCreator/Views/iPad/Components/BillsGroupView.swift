//
//  BillsGroupView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct BillsGroupView: View {
    let cash: Cash
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bills").bold().padding(.horizontal)
            
            DisplayPadCellView(type: .five, amount: cash.five)
            DisplayPadCellView(type: .ten, amount: cash.ten)
            DisplayPadCellView(type: .twenty, amount: cash.twenty)
            DisplayPadCellView(type: .fifty, amount: cash.fifty)
            DisplayPadCellView(type: .hundred, amount: cash.hundred)
            
            HStack {
                Text("Bill Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getBillTotal(cash))")
            }
            .font(.subheadline)
            .padding(.horizontal)
        }
    }
}

struct BillsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        BillsGroupView(cash: emptyCash)
    }
}
