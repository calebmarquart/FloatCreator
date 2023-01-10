//
//  BillsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct BillsSectionView: View {
    @AppStorage("show_images") private var showImages = true
    let cash: Cash
    
    var body: some View {
        Section {
            HStack {
                if showImages {
                Image("5")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                }
                Text("$5 Bills")
                Spacer()
                Text("\(cash.five) - ")
                Text("$\(cash.five * 5)").bold()
            }
            HStack {
                if showImages {
                Image("10")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                }
                Text("$10 Bills")
                Spacer()
                Text("\(cash.ten) - ")
                Text("$\(cash.ten * 10)").bold()
            }
            HStack {
                if showImages {
                Image("20")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                }
                Text("$20 Bills")
                Spacer()
                Text("\(cash.twenty) - ")
                Text("$\(cash.twenty * 20)").bold()
            }
            HStack {
                if showImages {
                Image("50")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                }
                Text("$50 Bills")
                Spacer()
                Text("\(cash.fifty) - ")
                Text("$\(cash.fifty * 50)").bold()
            }
            HStack {
                if showImages {
                Image("100")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                }
                Text("$100 Bills")
                Spacer()
                Text("\(cash.hundred) - ")
                Text("$\(cash.hundred * 100)").bold()
            }
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
