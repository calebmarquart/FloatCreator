//
//  RollsSectionView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct RollsSectionView: View {
    @AppStorage("show_images") private var showImages = true
    let cash: Cash
    
    var body: some View {
        Section {
            HStack {
                if showImages {
                Image(systemName: "n.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                }
                Text("Roll of Nickels")
                Spacer()
                Text("\(cash.rollNickels) - ")
                Text("$\(cash.rollNickels * 2)").bold()
            }
            HStack {
                if showImages {
                Image(systemName: "d.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                }
                Text("Roll of Dimes")
                Spacer()
                Text("\(cash.rollDimes) - ")
                Text("$\(cash.rollDimes * 5)").bold()
            }
            HStack {
                if showImages {
                Image(systemName: "q.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                }
                Text("Roll of Quarters")
                Spacer()
                Text("\(cash.rollQuarters) - ")
                Text("$\(cash.rollQuarters * 10)").bold()
            }
            HStack {
                if showImages {
                Image(systemName: "l.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                }
                Text("Roll of Loonies")
                Spacer()
                Text("\(cash.rollLoonies) - ")
                Text("$\(cash.rollLoonies * 25)").bold()
            }
            HStack {
                if showImages {
                Image(systemName: "t.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                }
                Text("Roll of Toonies")
                Spacer()
                Text("\(cash.rollToonies) - ")
                Text("$\(cash.rollToonies * 50)").bold()
            }
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
