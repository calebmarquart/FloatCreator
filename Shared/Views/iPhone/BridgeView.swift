//
//  NewFloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct BridgeView: View {
    @AppStorage("image_data") private var imageData = Data()
    
    @State private var itemForPrint: PrintQuery?
    @State private var showingInfo = false
    @State var till = ""
    @State var lead = ""
    
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
                        itemForPrint = PrintQuery(type: .float, cash: float, till: till, lead: lead, date: Date.now, image: imageData.toImage())
                    } label: {
                        Image(systemName: "printer")
                    }
                    
                    NavigationLink("Next") {
                        CashOutView(cash: cashout)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        itemForPrint = PrintQuery(type: .cashout, cash: cashout, till: till, lead: lead, date: Date.now, image: imageData.toImage())
                                    } label: {
                                        Image(systemName: "printer")
                                    }
                                }
                            }
                    }
                }
            }
            .sheet(item: $itemForPrint) { printItem in
                PrintView(print: printItem)
            }
            .sheet(isPresented: $showingInfo) {
                AddFloatInfoView(till: $till, lead: $lead, float: float, cashout: cashout)
            }
            .task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                showingInfo = true
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
