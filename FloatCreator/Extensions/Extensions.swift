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
