//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("float_amount") var floatAmount = 300
    
    @State private var five = ""
    @State private var ten = ""
    @State private var twenty = ""
    @State private var fifty = ""
    @State private var hundred = ""
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
    
    @State var configuration: Cash = emptyCash
    @State private var showingClearAlert = false
    @State private var showingNextView = false
    @State private var showingSettings = false
    @State private var showingList = false
    
    @FocusState var focusedField: MoneyType?
    
    let date: String
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        date = formatter.string(from: Date.now)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    iPhoneView
                } else {
                    iPadView
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        previousField()
                    } label: {
                        Image(systemName: "chevron.up")
                    }

                    Button {
                        nextField()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    
                    Spacer()

                    Button {
                        focusedField = nil
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showingList) {
            ListView()
        }
        .alert("Are you sure you want to clear float?", isPresented: $showingClearAlert) {
            Button("Clear", role: .destructive) {
                clearFloat()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    var iPhoneView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Money in Till")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(date).opacity(0.5)
                }
                
                Group {
                    Divider()
                    
                    Group {
                        Text("Bills")
                            .font(.headline)
                        
                        FloatCell(type: .five, text: $five, focus: _focusedField)
                        FloatCell(type: .ten, text: $ten, focus: _focusedField)
                        FloatCell(type: .twenty, text: $twenty, focus: _focusedField)
                        FloatCell(type: .fifty, text: $fifty, focus: _focusedField)
                        FloatCell(type: .hundred, text: $hundred, focus: _focusedField)
                        
                        HStack {
                            Text("Bill Total")
                            Spacer()
                            Text("$\(billTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Rolls")
                            .font(.headline)
                        FloatCell(type: .rollNickels, text: $rollNickels, focus: _focusedField)
                        FloatCell(type: .rollDimes, text: $rollDimes, focus: _focusedField)
                        FloatCell(type: .rollQuarters, text: $rollQuarters, focus: _focusedField)
                        FloatCell(type: .rollLoonies, text: $rollLoonies, focus: _focusedField)
                        FloatCell(type: .rollToonies, text: $rollToonies, focus: _focusedField)
                        HStack {
                            Text("Roll Total")
                            Spacer()
                            Text("$\(rollTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Coins")
                            .font(.headline)
                        FloatCell(type: .nickels, text: $nickels, focus: _focusedField)
                        FloatCell(type: .dimes, text: $dimes, focus: _focusedField)
                        FloatCell(type: .quarters, text: $quarters, focus: _focusedField)
                        FloatCell(type: .loonies, text: $loonies, focus: _focusedField)
                        FloatCell(type: .toonies, text: $toonies, focus: _focusedField)
                        
                        HStack {
                            Text("Coin Total")
                            Spacer()
                            Text("$\(coinTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        Divider()
                    }
                }
                HStack {
                    Text("Till Total")
                        .bold()
                    Spacer()
                    Text("$\(total(), specifier: "%.2f")")
                }
                .font(.title3)
                
                HStack {
                    Text("New Float Amount")
                    Spacer()
                    Text("$\(floatAmount)")
                }
                
                Button(action: calculate) {
                    Text("Continue")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 12)
                        .background(total() < Double(floatAmount) ? Color.secondary : Color.green)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .disabled(total() < Double(floatAmount))
            }
            .padding()
            
            NavigationLink(isActive: $showingNextView) {
                BridgeView(configuration: configuration)
            } label: {
                EmptyView()
            }
        }
        .navigationTitle("Create Float")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    showingList = true
                } label: {
                    Image(systemName: "list.bullet")
                }

            }
            
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
    }
    
    var iPadView: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        showingList = true
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.trailing, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Create Float")
                            .font(.title2)
                            .bold()
                        Text(date)
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    NavigationLink(destination: FloatCashoutPadView(configuration: configuration), isActive: $showingNextView) {
                        EmptyView()
                    }
                    
                    HStack(spacing: 22) {
                        Text("Till Total:").bold()
                        Text("$" + String(format: "%.2f", total())).bold()
                        
                        Button {
                            calculate()
                        } label: {
                            Text("Cashout")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.cyan)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(total() >= Double(floatAmount) ? Color.white : Color.white.opacity(0.5))
                                .cornerRadius(8)
                        }
                        .disabled(total() < Double(floatAmount))
                        
                    }
                    .foregroundColor(.white)
                    .font(.title2)
                    
                    
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.leading, 8)
                    }
                    
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
            }
            .background(Color.cyan)
            
            ScrollView {
                VStack {
                    HStack(spacing: 24) {
                        VStack {
                            Text("Bills").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .five, text: $five, focus: _focusedField)
                            FloatCell(type: .ten, text: $ten, focus: _focusedField)
                            FloatCell(type: .twenty, text: $twenty, focus: _focusedField)
                            FloatCell(type: .fifty, text: $fifty, focus: _focusedField)
                            FloatCell(type: .hundred, text: $hundred, focus: _focusedField)
                            HStack {
                                Text("Bill Total")
                                Spacer()
                                Text("$\(billTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Rolls").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .rollNickels, text: $rollNickels, focus: _focusedField)
                            FloatCell(type: .rollDimes, text: $rollDimes, focus: _focusedField)
                            FloatCell(type: .rollQuarters, text: $rollQuarters, focus: _focusedField)
                            FloatCell(type: .rollLoonies, text: $rollLoonies, focus: _focusedField)
                            FloatCell(type: .rollToonies, text: $rollToonies, focus: _focusedField)
                            HStack {
                                Text("Roll Total")
                                Spacer()
                                Text("$\(rollTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Coins").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .nickels, text: $nickels, focus: _focusedField)
                            FloatCell(type: .dimes, text: $dimes, focus: _focusedField)
                            FloatCell(type: .quarters, text: $quarters, focus: _focusedField)
                            FloatCell(type: .loonies, text: $loonies, focus: _focusedField)
                            FloatCell(type: .toonies, text: $toonies, focus: _focusedField)
                            HStack {
                                Text("Coin Total")
                                Spacer()
                                Text("$\(coinTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding()
                    .padding(.top, 8)
                }
            }
        }
    }
    
    private func billTotal() -> Double {
        let five = (Int(five) ?? 0) * 5
        let ten = (Int(ten) ?? 0) * 10
        let twenty = (Int(twenty) ?? 0) * 20
        let fifty = (Int(fifty) ?? 0) * 50
        let hundred = (Int(hundred) ?? 0) * 100
        
        return Double(five + ten + twenty + fifty + hundred)
    }
    
    private func coinTotal() -> Double {
        let n = (Double(nickels) ?? 0) * 0.05
        let d = (Double(dimes) ?? 0) * 0.1
        let q = (Double(quarters) ?? 0) * 0.25
        let l = (Double(loonies) ?? 0)
        let t = (Double(toonies) ?? 0) * 2
        
        return n + d + q + l + t
    }
    
    private func rollTotal() -> Double {
        let n = (Int(rollNickels) ?? 0) * 2
        let d = (Int(rollDimes) ?? 0) * 5
        let q = (Int(rollQuarters) ?? 0) * 10
        let l = (Int(rollLoonies) ?? 0) * 25
        let t = (Int(rollToonies) ?? 0) * 50
        
        return Double(n + d + q + l + t)
    }
    
    private func total() -> Double {
        return billTotal() + rollTotal() + coinTotal()
    }
    
    private func calculate() {
        configuration = Cash(dimes: Int(dimes) ?? 0, nickels: Int(nickels) ?? 0, quarters: Int(quarters) ?? 0, loonies: Int(loonies) ?? 0, toonies: Int(toonies) ?? 0, rollNickels: Int(rollNickels) ?? 0, rollDimes: Int(rollDimes) ?? 0, rollQuarters: Int(rollQuarters) ?? 0, rollLoonies: Int(rollLoonies) ?? 0, rollToonies: Int(rollToonies) ?? 0, five: Int(five) ?? 0, ten: Int(ten) ?? 0, twenty: Int(twenty) ?? 0, fifty: Int(fifty) ?? 0, hundred: Int(hundred) ?? 0)
        showingNextView = true
        
    }
    
    private func clearFloat() {
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
        five = ""
        ten = ""
        twenty = ""
        fifty = ""
        hundred = ""
        
        configuration = Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, five: 0, ten: 0, twenty: 0, fifty: 0, hundred: 0)
        
    }
    
    private func nextField() {
        guard let field = focusedField else { return }
        
        // Set the focuses field to the next one in the list
        switch field {
        case .nickels: focusedField = .dimes
        case .dimes: focusedField = .quarters
        case .quarters: focusedField = .loonies
        case .loonies: focusedField = .toonies
        case .toonies: focusedField = nil
        case .rollNickels: focusedField = .rollDimes
        case .rollDimes: focusedField = .rollQuarters
        case .rollQuarters: focusedField = .rollLoonies
        case .rollLoonies: focusedField = .rollToonies
        case .rollToonies: focusedField = .nickels
        case .five: focusedField = .ten
        case .ten: focusedField = .twenty
        case .twenty: focusedField = .fifty
        case .fifty: focusedField = .hundred
        case .hundred: focusedField = .rollNickels
        }
    }
    
    private func previousField() {
        guard let field = focusedField else { return }
        
        // Set the focused field to the previous one in the list
        switch field {
        case .nickels: focusedField = .rollToonies
        case .dimes: focusedField = .nickels
        case .quarters: focusedField = .dimes
        case .loonies: focusedField = .quarters
        case .toonies: focusedField = .loonies
        case .rollNickels: focusedField = .hundred
        case .rollDimes: focusedField = .rollNickels
        case .rollQuarters: focusedField = .rollDimes
        case .rollLoonies: focusedField = .rollQuarters
        case .rollToonies: focusedField = .rollLoonies
        case .five: focusedField = nil
        case .ten: focusedField = .five
        case .twenty: focusedField = .ten
        case .fifty: focusedField = .twenty
        case .hundred: focusedField = .fifty
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


