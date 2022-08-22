//
//  FloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct FloatView: View {
    @AppStorage("float_amount") private var floatAmount = 300
    
    let cash: Cash
    
    var body: some View {
        List {
            BillsSectionView(cash: cash)
            
            RollsSectionView(cash: cash)
            
            CoinsSectionView(cash: cash)
            
            Section("Float Total") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(ChangeMaker().getTotal(cash), specifier: "%.2f")").bold()
                }
            }
        }
    }
}