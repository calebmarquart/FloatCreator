//
//  NewFloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct PhoneSingleView: View {
    
    @State private var itemForPrint: PrintQuery?
    
    let float: PrintQuery
    let cashout: PrintQuery
    
    var body: some View {
        PhoneDetailView(type: .float, cash: float.cash)
            .navigationTitle("Suggested Float")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        itemForPrint = float
                    } label: {
                        Image(systemName: "printer")
                    }
                    
                    NavigationLink("Next") {
                        PhoneDetailView(type: .cashout, cash: cashout.cash)
                            .navigationTitle("Cashout")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        itemForPrint = cashout
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

struct PhoneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhoneDetailView(type: .float, cash: emptyCash)
        }
    }
}
