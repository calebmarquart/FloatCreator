//
//  FloatCashoutPadView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct FloatCashoutPadView: View {
    
    @State var itemForPrint: Cash?
    
    let float: Cash
    let cashout: Cash
    
    init(configuration: Cash) {
        self.cashout = ChangeMaker.instance.createCashout(from: configuration)
        self.float = ChangeMaker.instance.createFloat(original: configuration, cashout: cashout)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                CalculationDetailView(type: .float, cash: float)
                Divider()
                CalculationDetailView(type: .cashout, cash: cashout)
            }
            .padding(.horizontal)
            
            HStack {
                HStack(spacing: 20) {
                    Text("Float Total")
                    Text("$\(ChangeMaker.instance.getTotal(float), specifier: "%.2f")")
                        .bold()
                    Button {
                        // Print the float
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
                    Text("$\(ChangeMaker.instance.getTotal(cashout), specifier: "%.2f")")
                        .bold()
                    Button {
                        // Print the cashout
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
        .sheet(item: $itemForPrint) { printItem in
            PrintView(cash: printItem)
        }
    }
}

struct FloatCashoutPadView_Previews: PreviewProvider {
    static var previews: some View {
        FloatCashoutPadView(configuration: emptyCash)
    }
}


