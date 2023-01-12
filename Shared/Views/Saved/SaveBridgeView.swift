//
//  SaveBridgeView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct SaveBridgeView: View {
    
    @State private var showingPrint = false
    
    let float: Cash
    let cashout: Cash
    
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

struct SaveBridgeView_Previews: PreviewProvider {
    static var previews: some View {
        SaveBridgeView(float: emptyCash, cashout: emptyCash)
    }
}
