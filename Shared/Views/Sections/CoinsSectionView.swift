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
                cash.nickels.valueFormat(.nickels).bold()
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
                cash.dimes.valueFormat(.dimes).bold()
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
                cash.quarters.valueFormat(.quarters).bold()
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
                cash.loonies.valueFormat(.loonies).bold()
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
                cash.toonies.valueFormat(.toonies).bold()
            }
        } header: {
            Text("Coins")
        } footer: {
            HStack {
                Text("Coin Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getCoinTotal(cash), specifier: "%.2f")")
            }
        }
    } 
}
