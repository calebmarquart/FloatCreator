//
//  CoinsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct CoinsSectionView: View {
    let cash: Cash
    
    var body: some View {
        Section {
            DisplayPhoneCellView(type: .nickels, amount: cash.nickels)
            DisplayPhoneCellView(type: .dimes, amount: cash.dimes)
            DisplayPhoneCellView(type: .quarters, amount: cash.quarters)
            DisplayPhoneCellView(type: .loonies, amount: cash.loonies)
            DisplayPhoneCellView(type: .toonies, amount: cash.toonies)
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
