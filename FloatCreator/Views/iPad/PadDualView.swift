//
//  FloatCashoutPadView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct PadDualView: View {
    
    @State var itemForPrint: PrintQuery?
    
    let float: PrintQuery
    let cashout: PrintQuery
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                PadDetailView(type: .float, cash: float.cash)
                Divider()
                PadDetailView(type: .cashout, cash: cashout.cash)
            }
            .padding(.horizontal)
            
            bottomBar
        }
        .sheet(item: $itemForPrint) { printItem in
            PrintView(print: printItem)
        }
    }
    
    var bottomBar: some View {
        HStack {
            HStack(spacing: 20) {
                Text("Float Total")
                Text("$\(ChangeMaker.instance.getTotal(float.cash), specifier: "%.2f")")
                    .bold()
                Button {
                    itemForPrint = float
                } label: {
                    Image(systemName: "printer.fill")
                        .padding(10)
                        .foregroundColor(.cyan)
                        .font(.body)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.2), radius: 7, x: 0, y: 6)
                        )
                }
            }
            .font(.title3)
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 20) {
                Text("Cashout Total")
                Text("$\(ChangeMaker.instance.getTotal(cashout.cash), specifier: "%.2f")")
                    .bold()
                Button {
                    itemForPrint = cashout
                } label: {
                    Image(systemName: "printer.fill")
                        .padding(10)
                        .foregroundColor(.cyan)
                        .font(.body)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.2), radius: 7, x: 0, y: 6)
                        )
                }

            }
            .font(.title3)
            .frame(maxWidth: .infinity)
        }
        .padding(.top)
        .padding(.vertical, 8)
        .background(Color.white)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -3)
    }
    
}

struct FloatCashoutPadView_Previews: PreviewProvider {
    static var previews: some View {
        PadDualView(float: previewQuery, cashout: previewQuery)
    }
}


