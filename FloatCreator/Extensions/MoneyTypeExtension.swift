//
//  MoneyTypeExtension.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-20.
//

import SwiftUI

extension MoneyType {
    func imageWidth() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 28
        }
        
        switch self {
        case .five, .ten, .twenty, .fifty, .hundred:
            return 28
        case .rollDimes, .rollNickels, .rollQuarters, .rollLoonies, .rollToonies:
            return 28
        default: return 32
        }
    }
    
    func title() -> String {
        switch self {
        case .nickels:
            return "Nickels"
        case .dimes:
            return "Dimes"
        case .quarters:
            return "Quarters"
        case .loonies:
            return "Loonies"
        case .toonies:
            return "Toonies"
        case .rollNickels:
            return "Roll of Nickels"
        case .rollDimes:
            return "Roll of Dimes"
        case .rollQuarters:
            return "Roll of Quarters"
        case .rollLoonies:
            return "Roll of Loonies"
        case .rollToonies:
            return "Roll of Toonies"
        case .five:
            return "$5 Bills"
        case .ten:
            return "$10 Bills"
        case .twenty:
            return "$20 Bills"
        case .fifty:
            return "$50 Bills"
        case .hundred:
            return "$100 Bills"
        }
    }
    
    func image() -> Image {
        switch self {
        case .nickels:
            return Image("nickel")
        case .dimes:
            return Image("dime")
        case .quarters:
            return Image("quarter")
        case .loonies:
            return Image("loonie")
        case .toonies:
            return Image("toonie")
        case .rollNickels:
            return Image(systemName: "n.circle")
        case .rollDimes:
            return Image(systemName: "d.circle")
        case .rollQuarters:
            return Image(systemName: "q.circle")
        case .rollLoonies:
            return Image(systemName: "l.circle")
        case .rollToonies:
            return Image(systemName: "t.circle")
        case .five:
            return Image("5")
        case .ten:
            return Image("10")
        case .twenty:
            return Image("20")
        case .fifty:
            return Image("50")
        case .hundred:
            return Image("100")
        }
    }
    
    func isSystem() -> Bool {
        switch self {
        case .rollDimes, .rollNickels, .rollQuarters, .rollLoonies, .rollToonies:
            return true
        default: return false
        }
    }
    
    func symbol() -> String {
        switch self {
        case .nickels:
            return "N"
        case .dimes:
            return "D"
        case .quarters:
            return "Q"
        case .loonies:
            return "L"
        case .toonies:
            return "T"
        case .rollNickels:
            return "N"
        case .rollDimes:
            return "D"
        case .rollQuarters:
            return "Q"
        case .rollLoonies:
            return "L"
        case .rollToonies:
            return "T"
        case .five:
            return "5"
        case .ten:
            return "10"
        case .twenty:
            return "20"
        case .fifty:
            return "50"
        case .hundred:
            return "100"
        }
    }
    
    func multiplier() -> String {
        switch self {
        case .nickels:
            return "0.05"
        case .dimes:
            return "0.10"
        case .quarters:
            return "0.25"
        case .loonies:
            return "1.00"
        case .toonies:
            return "2.00"
        case .rollNickels:
            return "2"
        case .rollDimes:
            return "5"
        case .rollQuarters:
            return "10"
        case .rollLoonies:
            return "25"
        case .rollToonies:
            return "50"
        case .five:
            return "5"
        case .ten:
            return "10"
        case .twenty:
            return "20"
        case .fifty:
            return "50"
        case .hundred:
            return "100"
        }
    }
    
    
    func valueString(_ amount: Int) -> String {
        switch self {
        case .nickels:
            return String(format: "%.2f", Double(amount) * 0.05)
        case .dimes:
            return String(format: "%.2f", Double(amount) * 0.1)
        case .quarters:
            return String(format: "%.2f", Double(amount) * 0.25)
        case .loonies:
            return String(format: "%.2f", Double(amount))
        case .toonies:
            return String(format: "%.2f", Double(amount) * 2)
        case .rollNickels:
            return String(amount * 2)
        case .rollDimes:
            return String(amount * 5)
        case .rollQuarters:
            return String(amount * 10)
        case .rollLoonies:
            return String(amount * 25)
        case .rollToonies:
            return String(amount * 50)
        case .five:
            return String(amount * 5)
        case .ten:
            return String(amount * 10)
        case .twenty:
            return String(amount * 20)
        case .fifty:
            return String(amount * 50)
        case .hundred:
            return String(amount * 100)
        }
    }
    
}
