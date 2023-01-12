//
//  NewFloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct BridgeView: View {
    @State private var showingPrint = false
    
    let float: Cash
    let cashout: Cash
    
    init(configuration: Cash) {
        cashout = ChangeMaker.instance.createCashout(from: configuration)
        float = ChangeMaker.instance.createFloat(original: configuration, cashout: cashout)
    }
    
    var body: some View {
        FloatView(cash: float)
            .navigationTitle("Suggested Float")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button {
                        showingPrint.toggle()
                    } label: {
                        Image(systemName: "printer")
                    }

                    
                    NavigationLink("Next") {
                        CashOutView(cash: cashout)
                    }
                }
            }
            .sheet(isPresented: $showingPrint) {
                PrintView(cash: float)
            }
    }
}

struct BridgeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BridgeView(configuration:
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
