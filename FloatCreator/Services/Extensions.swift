//
//  Extensions.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-08.
//

import SwiftUI

extension Int {
    func value(_ type: MoneyType) -> Double {
        let amount = Double(self)
        
        switch type {
        case .nickels: return amount * 0.05
        case .dimes: return amount * 0.10
        case .quarters: return amount * 0.25
        case .loonies: return amount
        case .toonies: return amount * 2
            
        case .rollNickels: return amount * 2
        case .rollDimes: return amount * 5
        case .rollQuarters: return amount * 10
        case .rollLoonies: return amount * 25
        case .rollToonies: return amount * 50
            
        case .five: return amount * 5
        case .ten: return amount * 10
        case .twenty: return amount * 20
        case .fifty: return amount * 50
        case .hundred: return amount * 100
        }
    }
    
    func valuePrint(_ type: MoneyType) -> String {
        
        switch type {
        case .five:
            return "\t(5) \(self) x $5 \t $\(self * 5)"
        case .ten:
            return "\t(10) \(self) x $10 \t $\(self * 10)"
        case .twenty:
            return "\t(20) \(self) x $20 \t $\(self * 20)"
        case .fifty:
            return "\t(50) \(self) x $50 \t $\(self * 50)"
        case .hundred:
            return "\t(100) \(self) x $100 \t $\(self * 100)"
        case .rollNickels:
            return "\t(N) \(self) x $2 \t $\(self * 2)"
        case .rollDimes:
            return "\t(D) \(self) x $5 \t $\(self * 5)"
        case .rollQuarters:
            return "\t(Q) \(self) x $10 \t $\(self * 10)"
        case .rollLoonies:
            return "\t(L) \(self) x $25 \t $\(self * 25)"
        case .rollToonies:
            return "\t(T) \(self) x $50 \t $\(self * 50)"
        case .nickels:
            return "\t(N) \(self) x $0.05 \t $\(String(format: "%.2f", self.value(.nickels)))"
        case .dimes:
            return "\t(D) \(self) x $0.10 \t $\(String(format: "%.2f", self.value(.dimes)))"
        case .quarters:
            return "\t(Q) \(self) x $0.25 \t $\(String(format: "%.2f", self.value(.quarters)))"
        case .loonies:
            return "\t(L) \(self) x $1.00 \t $\(String(format: "%.2f", self.value(.loonies)))"
        case .toonies:
            return "\t(T) \(self) x $2.00 \t $\(String(format: "%.2f", self.value(.toonies)))"
        }
    }
    
    func valueFormat(_ type: MoneyType) -> Text {
        let double = self.value(type)
        
        return Text("$\(double, specifier: "%.2f")")
        
    }
    
    func valueString(_ type: MoneyType) -> String {
        switch type {
        case .nickels, .dimes, .quarters, .loonies, .toonies:
            return "$" + String(format: "%.2f", self.value(type))
        default:
            return "$" + String(Int(self.value(type)))
        }
    }
    
}

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
    
}

extension Date {
    func regularText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: self)
    }
}

extension String {
    func floatType() -> FloatType {
        if self == "Cashout" {
            return .cashout
        } else {
            return .float
        }
    }
    
    func moneyValue(_ type: MoneyType) -> Double {
        return (Int(self) ?? 0).value(type)
    }
    
}

extension Data {
    func toImage() -> UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else if let logo = UIImage(named: "logo") {
            return logo
        } else {
             return nil
        }
    }
}
