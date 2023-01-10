//
//  NewFloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct NewFloatView: View {
    @AppStorage("float_amount") private var floatAmount = 300
    @State private var float: Cash = emptyCash
    @State private var cashout: Cash = emptyCash
    
    let configuration: Cash
    
    var body: some View {
        FloatView(cash: float)
            .navigationTitle("Suggested Float")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Next") {
                        CashOutView(cash: cashout)
                    }
                }
            }
            .onAppear {
                cashout = ChangeMaker.instance.createCashout(from: configuration, float: floatAmount)
                float = ChangeMaker.instance.createFloat(original: configuration, cashout: cashout)
            }
    }
}

struct NewFloatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewFloatView(configuration:
                            Cash(dimes: 0,
                                 nickels: 0,
                                 quarters: 0,
                                 loonies: 0,
                                 toonies: 0,
                                 rollNickels: 0,
                                 rollDimes: 0,
                                 rollQuarters: 0,
                                 rollLoonies: 0,
                                 rollToonies: 0,
                                 five: 0,
                                 ten: 0,
                                 twenty: 0,
                                 fifty: 0,
                                 hundred: 0)
            )
        }
    }
}
