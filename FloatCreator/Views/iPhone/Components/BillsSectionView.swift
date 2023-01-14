//
//  BillsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct BillsSectionView: View {
    let cash: Cash
    
    var body: some View {
        Section {
            DisplayPhoneCellView(type: .five, amount: cash.five)
            DisplayPhoneCellView(type: .ten, amount: cash.ten)
            DisplayPhoneCellView(type: .twenty, amount: cash.twenty)
            DisplayPhoneCellView(type: .fifty, amount: cash.fifty)
            DisplayPhoneCellView(type: .hundred, amount: cash.hundred)
        } header: {
            Text("Bills")
        } footer: {
            HStack {
                Text("Bill Total")
                Spacer()
                Text("$\(ChangeMaker.instance.getBillTotal(cash))")
            }
        }
    }
}
