//
//  NewFloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct NewFloatView: View {
    let total: Double
    let configuration: Cash
    let change = ChangeMaker()
    @AppStorage("float_amount") private var floatAmount = 300
    @State private var float: Cash = emptyCash
    @State private var cashout: Cash = emptyCash
    
    var body: some View {
        FloatView(total: Double(floatAmount), cash: float)
            .navigationTitle("Suggested Float")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Next") {
                        CashOutView(total: total - Double(floatAmount), cash: cashout)
                    }
                }
            }
            .onAppear {
                cashout = change.makeChange(withCashout: total - Double(floatAmount), from: configuration)
                float = change.difference(original: configuration, cashout: cashout)
            }
    }
}

struct NewFloatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewFloatView(total: 447.35, configuration: Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, bill5: 0, bill10: 0, bill20: 0, bill50: 0, bill100: 0))
        }
    }
}
