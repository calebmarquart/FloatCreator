//
//  DisplayCalculationView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct PadDetailView: View {
    
    let type: FloatType
    let cash: Cash
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(type == .float ? "Suggested Float" : "Cashout")
                    .bold()
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                
                BillsGroupView(cash: cash)
                
                Divider()
                
                if type == .float {
                    
                    RollsGroupView(cash: cash)
                    
                    Divider()
                }
                
                CoinsGroupView(cash: cash)
            }
            .padding(.bottom, 24)
        }
    }
}

struct DisplayCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        PadDetailView(type: .float, cash: emptyCash)
    }
}
