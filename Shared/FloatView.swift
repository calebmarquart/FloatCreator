//
//  FloatView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct FloatView: View {
    let total: Double
    let cash: Cash
    
    var body: some View {
        List {
            Section("Coins") {
                HStack {
                    Text("Nickels")
                    Spacer()
                    Text("\(cash.nickels) - ")
                    Text("$\(Double(cash.bill100) * 0.05, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Dimes")
                    Spacer()
                    Text("\(cash.dimes) - ")
                    Text("$\(Double(cash.dimes) * 0.1, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Quarters")
                    Spacer()
                    Text("\(cash.quarters) - ")
                    Text("$\(Double(cash.quarters) * 0.25, specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Loonies")
                    Spacer()
                    Text("\(cash.loonies) - ")
                    Text("$\(Double(cash.loonies), specifier: "%.2f")").bold()
                }
                HStack {
                    Text("Toonies")
                    Spacer()
                    Text("\(cash.toonies) - ")
                    Text("$\(Double(cash.toonies * 2), specifier: "%.2f")").bold()
                }
            }
            Section("Bills") {
                HStack {
                    Text("$5 Bills")
                    Spacer()
                    Text("\(cash.bill5) - ")
                    Text("$\(cash.bill5 * 5)").bold()
                }
                HStack {
                    Text("$10 Bills")
                    Spacer()
                    Text("\(cash.bill10) - ")
                    Text("$\(cash.bill10 * 1)").bold()
                }
                HStack {
                    Text("$20 Bills")
                    Spacer()
                    Text("\(cash.bill20) - ")
                    Text("$\(cash.bill20 * 20)").bold()
                }
                HStack {
                    Text("$50 Bills")
                    Spacer()
                    Text("\(cash.bill50) - ")
                    Text("$\(cash.bill50 * 50)").bold()
                }
                HStack {
                    Text("$100 Bills")
                    Spacer()
                    Text("\(cash.bill100) - ")
                    Text("$\(cash.bill100 * 100)").bold()
                }
            }
            
            Section("Rolls") {
                HStack {
                    Text("Roll of Nickels")
                    Spacer()
                    Text("\(cash.rollNickels) - ")
                    Text("$\(cash.rollNickels * 2)").bold()
                }
                HStack {
                    Text("Roll of Dimes")
                    Spacer()
                    Text("\(cash.rollDimes) - ")
                    Text("$\(cash.rollDimes * 5)").bold()
                }
                HStack {
                    Text("Roll of Quarters")
                    Spacer()
                    Text("\(cash.rollQuarters) - ")
                    Text("$\(cash.rollQuarters * 10)").bold()
                }
                HStack {
                    Text("Roll of Loonies")
                    Spacer()
                    Text("\(cash.rollLoonies) - ")
                    Text("$\(cash.rollLoonies * 25)").bold()
                }
                HStack {
                    Text("Roll of Toonies")
                    Spacer()
                    Text("\(cash.rollToonies) - ")
                    Text("$\(cash.rollToonies * 50)").bold()
                }
            }
            
            Section("Float Total") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(total, specifier: "%.2f")").bold()
                }
            }
            
        }
    }
}
