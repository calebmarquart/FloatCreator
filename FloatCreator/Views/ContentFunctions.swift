//
//  ContentFunctions.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-13.
//

import SwiftUI

extension ContentView {
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
    
    func previousField() {
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
    
    func nextField() {
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
}
