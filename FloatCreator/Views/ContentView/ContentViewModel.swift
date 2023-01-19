//
//  ContentViewModel.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var five = ""
    @Published var ten = ""
    @Published var twenty = ""
    @Published var fifty = ""
    @Published var hundred = ""
    @Published var nickels = ""
    @Published var dimes = ""
    @Published var quarters = ""
    @Published var loonies = ""
    @Published var toonies = ""
    @Published var rollNickels = ""
    @Published var rollDimes = ""
    @Published var rollQuarters = ""
    @Published var rollLoonies = ""
    @Published var rollToonies = ""
    
    @Published var configuration: Cash = emptyCash
    
    @Published var showingNextView = false
    @Published var showingSettings = false
    @Published var showingList = false
    @Published var showingClearAlert = false
    
    @AppStorage("float_amount") var floatAmount = 300
    
    let date: String
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        date = formatter.string(from: Date.now)
    }
    
    
    func billTotal() -> Double {
        var total: Double = 0
        total += five.moneyValue(.five)
        total += ten.moneyValue(.ten)
        total += twenty.moneyValue(.twenty)
        total += fifty.moneyValue(.fifty)
        total += hundred.moneyValue(.hundred)
        return total
    }
    
    func coinTotal() -> Double {
        var total: Double = 0
        total += nickels.moneyValue(.nickels)
        total += dimes.moneyValue(.dimes)
        total += quarters.moneyValue(.quarters)
        total += loonies.moneyValue(.loonies)
        total += toonies.moneyValue(.toonies)
        return total
    }
    
    func rollTotal() -> Double {
        var total: Double = 0
        total += rollNickels.moneyValue(.rollNickels)
        total += rollDimes.moneyValue(.rollDimes)
        total += rollQuarters.moneyValue(.rollQuarters)
        total += rollLoonies.moneyValue(.rollLoonies)
        total += rollToonies.moneyValue(.rollToonies)
        return total
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
        
        configuration = emptyCash
    }
    
    
    
    
    func existingValue(newValue: MoneyType?) -> String {
        guard let type = newValue else { return "" }
        switch type {
        case .nickels:
            return nickels
        case .dimes:
            return dimes
        case .quarters:
            return quarters
        case .loonies:
            return loonies
        case .toonies:
            return toonies
        case .rollNickels:
            return rollNickels
        case .rollDimes:
            return rollDimes
        case .rollQuarters:
            return rollQuarters
        case .rollLoonies:
            return rollLoonies
        case .rollToonies:
            return rollToonies
        case .five:
            return five
        case .ten:
            return ten
        case .twenty:
            return twenty
        case .fifty:
            return fifty
        case .hundred:
            return hundred
        }
    }
    
    func updateNumber(newValue: String, activeEntry: MoneyType?) {
        guard let entry = activeEntry else { return }
        switch entry {
        case .nickels:
            nickels = newValue
        case .dimes:
            dimes = newValue
        case .quarters:
            quarters = newValue
        case .loonies:
            loonies = newValue
        case .toonies:
            toonies = newValue
        case .rollNickels:
            rollNickels = newValue
        case .rollDimes:
            rollDimes = newValue
        case .rollQuarters:
            rollQuarters = newValue
        case .rollLoonies:
            rollLoonies = newValue
        case .rollToonies:
            rollToonies = newValue
        case .five:
            five = newValue
        case .ten:
            ten = newValue
        case .twenty:
            twenty = newValue
        case .fifty:
            fifty = newValue
        case .hundred:
            hundred = newValue
        }
    }
    
}
