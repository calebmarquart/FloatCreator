//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("float_amount") var floatAmount = 300
    @AppStorage("show_images") private var showImages = true
    
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
    @State private var five = ""
    @State private var ten = ""
    @State private var twenty = ""
    @State private var fifty = ""
    @State private var hundred = ""
    @State private var showingNextView = false
    @State private var showingSettings = false
    @State private var showingClearAlert = false
    @State private var configuration = emptyCash
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Money in Till")
                        .font(.title3)
                        .bold()
                    
                    Group {
                        Divider()
                        bills
                        rolls
                        coins
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
                    NewFloatView(configuration: configuration)
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
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        focusedField = nil
                    } label: {
                        Text("Close")
                    }
                    Spacer()
                    Button {
                        updateFocusedField()
                    } label: {
                        Text("Next")
                    }
                }
            }
            .alert("Are you sure you want to clear float?", isPresented: $showingClearAlert) {
                Button("Clear", role: .destructive) {
                    clearFloat()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    var coins: some View {
        Group {
            Text("Coins")
                .font(.headline)
            HStack {
                if showImages {
                    Image("nickel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                TextField("Nickels", text: $nickels)
                    .focused($focusedField, equals: .nickels)
                    .textField()
                Text("x 0.05 = ")
                Text("\((Double(nickels) ?? 0) * 0.05, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("dime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                TextField("Dimes", text: $dimes)
                    .focused($focusedField, equals: .dimes)
                    .textField()
                Text("x 0.10 = ")
                Text("\((Double(dimes) ?? 0) * 0.1, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("quarter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                TextField("Quarters", text: $quarters)
                    .focused($focusedField, equals: .quarters)
                    .textField()
                Text("x 0.25 = ")
                Text("\((Double(quarters) ?? 0) * 0.25, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("loonie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                TextField("Loonies", text: $loonies)
                    .focused($focusedField, equals: .loonies)
                    .textField()
                Text("x 1.00 = ")
                Text("\((Double(loonies) ?? 0) * 1, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("toonie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                TextField("Toonies", text: $toonies)
                    .focused($focusedField, equals: .toonies)
                    .textField()
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
            Divider()
        }
        .keyboardType(.numberPad)
    }
    
    var rolls: some View {
        Group {
            Text("Coin Rolls")
                .font(.headline)
            HStack {
                if showImages {
                    Image(systemName: "n.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primary).opacity(0.2)
                        .frame(width: 28, height: 28)
                }
                TextField("Roll of Nickels", text: $rollNickels)
                    .focused($focusedField, equals: .rollNickels)
                    .textField()
                Text("x 2 = ")
                Text("\((Int(rollNickels) ?? 0) * 2)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image(systemName: "d.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primary).opacity(0.2)
                        .frame(width: 28, height: 28)
                }
                TextField("Roll of Dimes", text: $rollDimes)
                    .focused($focusedField, equals: .rollDimes)
                    .textField()
                Text("x 5 = ")
                Text("\((Int(rollDimes) ?? 0) * 5)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image(systemName: "q.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primary).opacity(0.2)
                        .frame(width: 28, height: 28)
                }
                TextField("Roll of Quarters", text: $rollQuarters)
                    .focused($focusedField, equals: .rollQuarters)
                    .textField()
                Text("x 10 = ")
                Text("\((Int(rollQuarters) ?? 0) * 10)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image(systemName: "l.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primary).opacity(0.2)
                        .frame(width: 28, height: 28)
                }
                TextField("Roll of Loonies", text: $rollLoonies)
                    .focused($focusedField, equals: .rollLoonies)
                    .textField()
                Text("x 25 = ")
                Text("\((Int(rollLoonies) ?? 0) * 25)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image(systemName: "t.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primary).opacity(0.2)
                        .frame(width: 28, height: 28)
                }
                TextField("Roll of Toonies", text: $rollToonies)
                    .focused($focusedField, equals: .rollToonies)
                    .textField()
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
            
            Divider()
        }
        .keyboardType(.numberPad)
    }
    
    var bills: some View {
        Group {
            Text("Bills")
                .font(.headline)
            HStack {
                if showImages {
                    Image("5")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
                TextField("$5 Bills", text: $five)
                    .focused($focusedField, equals: .five)
                    .textField()
                Text("x 5 = ")
                Text("\((Int(five) ?? 0) * 5)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("10")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
                TextField("$10 Bills", text: $ten)
                    .focused($focusedField, equals: .ten)
                    .textField()
                Text("x 10 = ")
                Text("\((Int(ten) ?? 0) * 10)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("20")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
                TextField("$20 Bills", text: $twenty)
                    .focused($focusedField, equals: .twenty)
                    .textField()
                Text("x 20 = ")
                Text("\((Int(twenty) ?? 0) * 20)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("50")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
                TextField("$50 Bills", text: $fifty)
                    .focused($focusedField, equals: .fifty)
                    .textField()
                Text("x 50 = ")
                Text("\((Int(fifty) ?? 0) * 50)")
                    .bold()
            }
            HStack {
                if showImages {
                    Image("100")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
                TextField("$100 Bills", text: $hundred)
                    .focused($focusedField, equals: .hundred)
                    .textField()
                Text("x 100 = ")
                Text("\((Int(hundred) ?? 0) * 100)")
                    .bold()
            }
            HStack {
                Text("Total")
                Spacer()
                Text("$\(billTotal(), specifier: "%.2f")")
            }
            .font(.subheadline)
            
            Divider()
        }
        .keyboardType(.numberPad)
    }
    
    func coinTotal() -> Double {
        let n = (Double(nickels) ?? 0) * 0.05
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
        let five = (Int(five) ?? 0) * 5
        let ten = (Int(ten) ?? 0) * 10
        let twenty = (Int(twenty) ?? 0) * 20
        let fifty = (Int(fifty) ?? 0) * 50
        let hundred = (Int(hundred) ?? 0) * 100
        
        return Double(five + ten + twenty + fifty + hundred)
    }
    
    func total() -> Double {
        return billTotal() + rollTotal() + coinTotal()
    }
    
    func calculate() {
        configuration = Cash(dimes: Int(dimes) ?? 0, nickels: Int(nickels) ?? 0, quarters: Int(quarters) ?? 0, loonies: Int(loonies) ?? 0, toonies: Int(toonies) ?? 0, rollNickels: Int(rollNickels) ?? 0, rollDimes: Int(rollDimes) ?? 0, rollQuarters: Int(rollQuarters) ?? 0, rollLoonies: Int(rollLoonies) ?? 0, rollToonies: Int(rollToonies) ?? 0, five: Int(five) ?? 0, ten: Int(ten) ?? 0, twenty: Int(twenty) ?? 0, fifty: Int(fifty) ?? 0, hundred: Int(hundred) ?? 0)
        showingNextView = true
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
        five = ""
        ten = ""
        twenty = ""
        fifty = ""
        hundred = ""
        
        configuration = Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, five: 0, ten: 0, twenty: 0, fifty: 0, hundred: 0)
        
    }
    
    func updateFocusedField() {
        guard let field = focusedField else {
            return
        }
        
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
    
    enum Field {
        case nickels
        case dimes
        case quarters
        case loonies
        case toonies
        case rollNickels
        case rollDimes
        case rollQuarters
        case rollLoonies
        case rollToonies
        case five
        case ten
        case twenty
        case fifty
        case hundred
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let emptyCash = Cash(dimes: 0,
                     nickels: 0,
                     quarters: 0,
                     loonies: 0,
                     toonies: 0,
                     rollNickels: 0,
                     rollDimes: 0,
                     rollQuarters: 0,
                     rollLoonies: 0,
                     rollToonies: 0,
                     five: 0,
                     ten: 0,
                     twenty: 0,
                     fifty: 0,
                     hundred: 0)
