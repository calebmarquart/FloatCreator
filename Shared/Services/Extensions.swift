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
    
    func valueFormat(_ type: MoneyType) -> Text {
        let double = self.value(type)
        
        return Text("$\(double, specifier: "%.2f")")
        
    }
    
}
