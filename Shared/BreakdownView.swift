//
//  BreakdownView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct BreakdownView: View {
    let total: Double
    let configuration: Cash
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("Profits")
                    .font(.title)
                Text("$\(total - Double(300), specifier: "%.2f")")
                    .foregroundColor(.green)
                    .font(.largeTitle)
            }
            HStack(spacing: 50) {
                VStack {
                    Text("Float Total")
                        .font(.headline)
                    Text("$300.00")
                        .font(.title3)
                }
                
                VStack {
                    Text("Till Total")
                        .font(.headline)
                    Text("$\(total, specifier: "%.2f")")
                        .font(.title3)
                }
            }
            .padding()
            
            NavigationLink {
                NewFloatView(total: total, configuration: configuration)
            } label: {
                Text("Continue")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 36)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .padding()
            }

            
        }
        .navigationTitle("Breakdown")
    }
}

struct BreakdownView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BreakdownView(total: 447.35, configuration: Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, bill5: 0, bill10: 0, bill20: 0, bill50: 0, bill100: 0))
        }
    }
}
