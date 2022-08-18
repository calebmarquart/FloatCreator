//
//  CoinsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct CoinsSectionView: View {
    @AppStorage("show_images") private var showImages = true
    let cash: Cash
    
    var body: some View {
        Section {
            HStack {
                if showImages {
                Image("nickel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                }
                Text("Nickels")
                Spacer()
                Text("\(cash.nickels) - ")
                Text("$\(Double(cash.nickels) * 0.05, specifier: "%.2f")").bold()
            }
            HStack {
                if showImages {
                Image("dime")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                }
                Text("Dimes")
                Spacer()
                Text("\(cash.dimes) - ")
                Text("$\(Double(cash.dimes) * 0.1, specifier: "%.2f")").bold()
            }
            HStack {
                if showImages {
                Image("quarter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                }
                Text("Quarters")
                Spacer()
                Text("\(cash.quarters) - ")
                Text("$\(Double(cash.quarters) * 0.25, specifier: "%.2f")").bold()
            }
            HStack {
                if showImages {
                Image("loonie")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                }
                Text("Loonies")
                Spacer()
                Text("\(cash.loonies) - ")
                Text("$\(Double(cash.loonies), specifier: "%.2f")").bold()
            }
            HStack {
                if showImages {
                Image("toonie")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                }
                Text("Toonies")
                Spacer()
                Text("\(cash.toonies) - ")
                Text("$\(Double(cash.toonies * 2), specifier: "%.2f")").bold()
            }
        } header: {
            Text("Coins")
        } footer: {
            HStack {
                Text("Coin Total")
                Spacer()
                Text("$\(Double(cash.nickels) * 0.05 + Double(cash.dimes) * 0.1 + Double(cash.quarters) * 0.25 + Double(cash.loonies) + Double(cash.toonies) * 2, specifier: "%.2f")")
            }
        }
    }
}
