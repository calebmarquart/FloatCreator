//
//  SaveDetailView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct SaveFloatView: View {
    
    @State var itemForPrint: PrintQuery?
    
    let floatPrint: PrintQuery
    let cashoutPrint: PrintQuery
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                CalculationDetailView(type: .float, cash: floatPrint.cash)
                Divider()
                CalculationDetailView(type: .cashout, cash: cashoutPrint.cash)
            }
            .padding(.horizontal)
            
            HStack {
                HStack(spacing: 20) {
                    Text("Float Total")
                    Text("$\(ChangeMaker.instance.getTotal(floatPrint.cash), specifier: "%.2f")")
                        .bold()
                    Button {
                        // Print the float
                        itemForPrint = floatPrint
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
                    Text("$\(ChangeMaker.instance.getTotal(cashoutPrint.cash), specifier: "%.2f")")
                        .bold()
                    Button {
                        // Print the cashout
                        itemForPrint = cashoutPrint
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
        .sheet(item: $itemForPrint) { printItem in
            PrintView(print: printItem)
        }
    }
}

struct SaveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SaveFloatView(floatPrint: previewQuery, cashoutPrint: previewQuery)
    }
}
