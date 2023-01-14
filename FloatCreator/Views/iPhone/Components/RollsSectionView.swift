//
//  RollsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct RollsSectionView: View {
    let cash: Cash
    
    var body: some View {
        Section {
            DisplayPhoneCellView(type: .rollNickels, amount: cash.rollNickels)
            DisplayPhoneCellView(type: .rollDimes, amount: cash.rollDimes)
            DisplayPhoneCellView(type: .rollQuarters, amount: cash.rollQuarters)
            DisplayPhoneCellView(type: .rollLoonies, amount: cash.rollLoonies)
            DisplayPhoneCellView(type: .rollToonies, amount: cash.rollToonies)
        } header: {
            Text("Rolls")
        } footer: {
            HStack {
                Text("Roll Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getRollTotal(cash))")
            }
        }
    }
}
