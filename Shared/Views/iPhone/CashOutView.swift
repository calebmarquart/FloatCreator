//
//  FloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct CashOutView: View {
    let cash: Cash
    
    var body: some View {
        List {
            BillsSectionView(cash: cash)
            
            CoinsSectionView(cash: cash)
            
            Section("Cashout Total") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(ChangeMaker.instance.getTotal(cash), specifier: "%.2f")").bold()
                }
            }
        }
        .navigationTitle("Cash Out")
    }
}
