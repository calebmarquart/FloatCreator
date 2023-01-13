//
//  SaveBridgeView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct SaveBridgeView: View {
    
    @State private var itemForPrint: PrintQuery?
    
    let floatPrint: PrintQuery
    let cashoutPrint: PrintQuery
    
    var body: some View {
        FloatView(cash: floatPrint.cash)
            .navigationTitle("Suggested Float")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        itemForPrint = floatPrint
                    } label: {
                        Image(systemName: "printer")
                    }
                    
                    NavigationLink("Next") {
                        CashOutView(cash: cashoutPrint.cash)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        itemForPrint = cashoutPrint
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
    }
}

struct SaveBridgeView_Previews: PreviewProvider {
    static var previews: some View {
        SaveBridgeView(floatPrint: previewQuery, cashoutPrint: previewQuery)
    }
}

let previewQuery = PrintQuery(type: .float, cash: emptyCash, till: "Rentals", lead: "Employee", date: Date.now, image: nil)
