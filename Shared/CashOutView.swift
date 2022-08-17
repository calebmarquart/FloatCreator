//
//  FloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct CashOutView: View {
    let total: Double
    let cash: Cash
    
    var body: some View {
        List {
            Section("Bills") {
                HStack {
                    Text("$100 Bills")
                    Spacer()
                    Text("\(cash.bill100) - ")
                    Text("$\(cash.bill100 * 100)").bold()
                }
                HStack {
                    Text("$50 Bills")
                    Spacer()
                    Text("\(cash.bill50) - ")
                    Text("$\(cash.bill50 * 50)").bold()
                }
                HStack {
                    Text("$20 Bills")
                    Spacer()
                    Text("\(cash.bill20) - ")
                    Text("$\(cash.bill20 * 20)").bold()
                }
                HStack {
                    Text("$10 Bills")
                    Spacer()
                    Text("\(cash.bill10) - ")
                    Text("$\(cash.bill10 * 1)").bold()
                }
                HStack {
                    Text("$5 Bills")
                    Spacer()
                    Text("\(cash.bill5) - ")
                    Text("$\(cash.bill5 * 5)").bold()
                }
            }
            
            Section("Coins") {
                HStack {
                    Text("Toonies")
                    Spacer()
                    Text("\(cash.toonies) - ")
                    Text("$\(cash.toonies * 2, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Loonies")
                    Spacer()
                    Text("\(cash.loonies) - ")
                    Text("$\(cash.loonies, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Quarters")
                    Spacer()
                    Text("\(cash.quarters) - ")
                    Text("$\(Double(cash.quarters) * 0.25, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Dimes")
                    Spacer()
                    Text("\(cash.dimes) - ")
                    Text("$\(Double(cash.dimes) * 0.1, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Nickels")
                    Spacer()
                    Text("\(cash.nickels) - ")
                    Text("$\(Double(cash.bill100) * 0.05, specifier: "%.2f")").bold()
                }
            }
            
            Section("Total Cashout") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(total, specifier: "%.2f")").bold()
                }
            }
            
        }
    }
}

struct CashOutView_Previews: PreviewProvider {
    static var previews: some View {
        CashOutView(total: 147.65, cash: Cash(dimes: 6, nickels: 5, quarters: 9, loonies: 6, toonies: 7, rollNickels: 4, rollDimes: 5, rollQuarters: 3, rollLoonies: 5, rollToonies: 8, bill5: 6, bill10: 7, bill20: 9, bill50: 4, bill100: 6))
    }
}
