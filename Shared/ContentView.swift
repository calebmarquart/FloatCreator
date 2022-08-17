//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    @State private var nickels = ""
    @State private var dimes = ""
    @State private var quarters = ""
    @State private var loonies = ""
    @State private var toonies = ""
    
    @State private var rollNickels = ""
    @State private var rollDimes = ""
    @State private var rollQuarters = ""
    @State private var rollLoonies = ""
    @State private var rollToonies = ""
    
    @State private var bill5 = ""
    @State private var bill10 = ""
    @State private var bill20 = ""
    @State private var bill50 = ""
    @State private var bill100 = ""
    
    @State private var showingNextView = false
    @State private var showingSettings = false
    @State private var showingClearAlert = false
    @State private var configuration = Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, bill5: 0, bill10: 0, bill20: 0, bill50: 0, bill100: 0)
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Money in Till")
                        .font(.title3)
                        .bold()
                    Divider()
                    coins
                    Divider()
                    rolls
                    Divider()
                    bills
                    Divider()
                    HStack {
                        Text("Grand Total")
                            .bold()
                        Spacer()
                        Text("$\(coinTotal() + rollTotal() + billTotal(), specifier: "%.2f")")
                    }
                    .font(.title3)
                    Button {
                        configuration = Cash(dimes: Int(dimes) ?? 0, nickels: Int(nickels) ?? 0, quarters: Int(quarters) ?? 0, loonies: Int(loonies) ?? 0, toonies: Int(toonies) ?? 0, rollNickels: Int(rollNickels) ?? 0, rollDimes: Int(rollDimes) ?? 0, rollQuarters: Int(rollQuarters) ?? 0, rollLoonies: Int(rollLoonies) ?? 0, rollToonies: Int(rollToonies) ?? 0, bill5: Int(bill5) ?? 0, bill10: Int(bill10) ?? 0, bill20: Int(bill20) ?? 0, bill50: Int(bill50) ?? 0, bill100: Int(bill100) ?? 0)
                        showingNextView = true
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
                .padding()
                .textFieldStyle(.roundedBorder)
                
                NavigationLink(isActive: $showingNextView) {
                    BreakdownView(total: coinTotal() + rollTotal() + billTotal(), configuration: configuration)
                } label: {
                    EmptyView()
                }
            }
            .navigationTitle("Create Float")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingClearAlert = true
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }


                }
            }
            .alert("Are you sure you want to clear float?", isPresented: $showingClearAlert) {
                Button("Clear", role: .destructive) {
                    clearFloat()
                }
                Button("Cancel", role: .cancel) {}
            }
            .sheet(isPresented: $showingSettings) {
                Text("Settings")
            }
        }
    }
    
    var coins: some View {
        Group {
            Text("Coins")
                .font(.headline)
            HStack {
                TextField("Nickels", text: $nickels)
                Text("x 0.05 = ")
                Text("\((Double(nickels) ?? 0) * 0.05, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                TextField("Dimes", text: $dimes)
                Text("x 0.10 = ")
                Text("\((Double(dimes) ?? 0) * 0.1, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                TextField("Quarters", text: $quarters)
                Text("x 0.25 = ")
                Text("\((Double(quarters) ?? 0) * 0.25, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                TextField("Loonies", text: $loonies)
                Text("x 1.00 = ")
                Text("\((Double(loonies) ?? 0) * 1, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                TextField("Toonies", text: $toonies)
                Text("x 2.00 = ")
                Text("\((Double(toonies) ?? 0) * 2, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                Text("Total")
                Spacer()
                Text("$\(coinTotal(), specifier: "%.2f")")
            }
            .font(.subheadline)
        }
        .keyboardType(.numberPad)
    }
    
    var rolls: some View {
        Group {
            Text("Coin Rolls")
                .font(.headline)
            HStack {
                TextField("Roll of Nickels", text: $rollNickels)
                Text("x 2 = ")
                Text("\((Int(rollNickels) ?? 0) * 2)")
                    .bold()
            }
            HStack {
                TextField("Roll of Dimes", text: $rollDimes)
                Text("x 5 = ")
                Text("\((Int(rollDimes) ?? 0) * 5)")
                    .bold()
            }
            HStack {
                TextField("Roll of Quarters", text: $rollQuarters)
                Text("x 10 = ")
                Text("\((Int(rollQuarters) ?? 0) * 10)")
                    .bold()
            }
            HStack {
                TextField("Roll of Loonies", text: $rollLoonies)
                Text("x 25 = ")
                Text("\((Int(rollLoonies) ?? 0) * 25)")
                    .bold()
            }
            HStack {
                TextField("Roll of Toonies", text: $rollToonies)
                Text("x 50 = ")
                Text("\((Int(rollToonies) ?? 0) * 50)")
                    .bold()
            }
            HStack {
                Text("Total")
                Spacer()
                Text("$\(rollTotal(), specifier: "%.2f")")
            }
            .font(.subheadline)
        }
        .keyboardType(.numberPad)
    }
    
    var bills: some View {
        Group {
            Text("Bills")
                .font(.headline)
            HStack {
                TextField("$5 Bills", text: $bill5)
                Text("x 5 = ")
                Text("\((Int(bill5) ?? 0) * 5)")
                    .bold()
            }
            HStack {
                TextField("$10 Bills", text: $bill10)
                Text("x 5 = ")
                Text("\((Int(bill10) ?? 0) * 10)")
                    .bold()
            }
            HStack {
                TextField("$20 Bills", text: $bill20)
                Text("x 20 = ")
                Text("\((Int(bill20) ?? 0) * 20)")
                    .bold()
            }
            HStack {
                TextField("$50 Bills", text: $bill50)
                Text("x 50 = ")
                Text("\((Int(bill50) ?? 0) * 50)")
                    .bold()
            }
            HStack {
                TextField("$100 Bills", text: $bill100)
                Text("x 100 = ")
                Text("\((Int(bill100) ?? 0) * 100)")
                    .bold()
            }
            HStack {
                Text("Total")
                Spacer()
                Text("$\(billTotal(), specifier: "%.2f")")
            }
            .font(.subheadline)
        }
        .keyboardType(.numberPad)
    }
    
    func coinTotal() -> Double {
        let n = (Double(nickels) ?? 0) * 0.5
        let d = (Double(dimes) ?? 0) * 0.1
        let q = (Double(quarters) ?? 0) * 0.25
        let l = (Double(loonies) ?? 0)
        let t = (Double(toonies) ?? 0) * 2
        
        return n + d + q + l + t
    }
    
    func rollTotal() -> Double {
        let n = (Int(rollNickels) ?? 0) * 2
        let d = (Int(rollDimes) ?? 0) * 5
        let q = (Int(rollQuarters) ?? 0) * 10
        let l = (Int(rollLoonies) ?? 0) * 25
        let t = (Int(rollToonies) ?? 0) * 50
        
        return Double(n + d + q + l + t)
    }
    
    func billTotal() -> Double {
        let five = (Int(bill5) ?? 0) * 5
        let ten = (Int(bill10) ?? 0) * 10
        let twenty = (Int(bill20) ?? 0) * 20
        let fifty = (Int(bill50) ?? 0) * 50
        let hundred = (Int(bill100) ?? 0) * 100
        
        return Double(five + ten + twenty + fifty + hundred)
    }
    
    func clearFloat() {
        nickels = ""
        dimes = ""
        quarters = ""
        loonies = ""
        toonies = ""
        rollNickels = ""
        rollDimes = ""
        rollQuarters = ""
        rollLoonies = ""
        rollToonies = ""
        bill5 = ""
        bill10 = ""
        bill20 = ""
        bill50 = ""
        bill100 = ""
        
        configuration = Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, bill5: 0, bill10: 0, bill20: 0, bill50: 0, bill100: 0)
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
