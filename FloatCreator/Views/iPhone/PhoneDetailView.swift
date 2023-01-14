//
//  FloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct PhoneDetailView: View {
    
    let type: FloatType
    let cash: Cash
    
    var body: some View {
        List {
            BillsSectionView(cash: cash)
            
            if type == .float {
                RollsSectionView(cash: cash)
            }
            
            CoinsSectionView(cash: cash)
            
            Section("\(type.string()) Total") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(ChangeMaker.instance.getTotal(cash), specifier: "%.2f")").bold()
                }
            }
        }
    }
}
