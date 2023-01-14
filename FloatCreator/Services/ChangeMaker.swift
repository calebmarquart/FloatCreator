//
//  ChangeMaker.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

class ChangeMaker {
    
    @AppStorage("float_amount") private var floatAmount = 300
    
    static let instance = ChangeMaker()
    
    func createCashout(from configuration: Cash) -> Cash {
        var total = getTotal(configuration) - Double(floatAmount)
        
        var nickels = 0
        var dimes = 0
        var quarters = 0
        var loonies = 0
        var toonies = 0
        var five = 0
        var ten = 0
        var twenty = 0
        var fifty = 0
        var hundred = 0
        
        // 100 Bills
        hundred = getGoodAmount(amount: configuration.hundred, type: .hundred, total: total)
        total -= hundred.value(.hundred)
        
        // 50 Bills
        fifty = getGoodAmount(amount: configuration.fifty, type: .fifty, total: total)
        total -= fifty.value(.fifty)
        
        // 20 Bills
        twenty = getGoodAmount(amount: configuration.twenty, type: .twenty, total: total)
        total -= twenty.value(.twenty)
        
        // 10 Bill
        ten = getGoodAmount(amount: configuration.ten, type: .ten, total: total)
        total -= ten.value(.ten)
        
        // 5 Bill
        five = getGoodAmount(amount: configuration.five, type: .five, total: total)
        total -= five.value(.five)
        
        // Toonies
        toonies = getGoodAmount(amount: configuration.toonies, type: .toonies, total: total)
        total -= toonies.value(.toonies)
        
        // Loonies
        loonies = getGoodAmount(amount: configuration.loonies, type: .loonies, total: total)
        total -= loonies.value(.loonies)
        
        // Quarters
        quarters = getGoodAmount(amount: configuration.quarters, type: .quarters, total: total)
        total -= quarters.value(.quarters)
        
        // Dimes
        dimes = getGoodAmount(amount: configuration.dimes, type: .dimes, total: total)
        total -= dimes.value(.dimes)
        
        // Nickels
        nickels = getGoodAmount(amount: configuration.nickels, type: .nickels, total: total)
        total -= nickels.value(.nickels)
        
        return Cash(dimes: dimes,
                    nickels: nickels,
                    quarters: quarters,
                    loonies: loonies,
                    toonies: toonies,
                    rollNickels: 0,
                    rollDimes: 0,
                    rollQuarters: 0,
                    rollLoonies: 0,
                    rollToonies: 0,
                    five: five,
                    ten: ten,
                    twenty: twenty,
                    fifty: fifty,
                    hundred: hundred
        )
    }
    
    private func getGoodAmount(amount: Int, type: MoneyType, total: Double) -> Int {
        guard amount != 0 else { return 0 }
        
        let maxMoney = Int(Float(total / 1.value(type)))
        if amount <= maxMoney {
            return amount
        } else {
            return maxMoney
        }
    }
    
    func createFloat(original: Cash, cashout: Cash) -> Cash {
        let dimes = original.dimes - cashout.dimes
        let nickels = original.nickels - cashout.nickels
        let quarters = original.quarters - cashout.quarters
        let loonies = original.loonies - cashout.loonies
        let toonies = original.toonies - cashout.toonies
        let rollNickels = original.rollNickels
        let rollDimes = original.rollDimes
        let rollQuarters = original.rollQuarters
        let rollLoonies = original.rollLoonies
        let rollToonies = original.rollToonies
        let bill5 = original.five - cashout.five
        let bill10 = original.ten - cashout.ten
        let bill20 = original.twenty - cashout.twenty
        let bill50 = original.fifty - cashout.fifty
        let bill100 = original.hundred - cashout.hundred
        
        return Cash(dimes: dimes, nickels: nickels, quarters: quarters, loonies: loonies, toonies: toonies, rollNickels: rollNickels, rollDimes: rollDimes, rollQuarters: rollQuarters, rollLoonies: rollLoonies, rollToonies: rollToonies, five: bill5, ten: bill10, twenty: bill20, fifty: bill50, hundred: bill100)
        
    }
    
    /// The sum of the total of all the items in a Cash object
    /// - Parameter cash: A Cash object
    /// - Returns: The total as a double
    func getTotal(_ cash: Cash) -> Double {
        return getCoinTotal(cash) + Double(getRollTotal(cash)) + Double(getBillTotal(cash))
    }
    
    /// Gets the coin total from a Cash object
    /// - Parameter cash: A cash object
    /// - Returns: A double with the total value
    func getCoinTotal(_ cash: Cash) -> Double {
        return cash.nickels.value(.nickels) +
        cash.dimes.value(.dimes) +
        cash.quarters.value(.quarters) +
        cash.loonies.value(.loonies) +
        cash.toonies.value(.toonies)
    }
    
    /// Gets the total value for all the bills in a Cash object
    /// - Parameter cash: A Cash object
    /// - Returns: An integer with the total value
    func getBillTotal(_ cash: Cash) -> Int {
        return cash.five * 5 +
        cash.ten * 10 +
        cash.twenty * 20 +
        cash.fifty * 50 +
        cash.hundred * 100
    }
    
    /// Gets the total for all the rolled coins in a Cash object
    /// - Parameter cash: A Cash object
    /// - Returns: An integer with the total value
    func getRollTotal(_ cash: Cash) -> Int {
        return cash.rollNickels * 2 +
        cash.rollDimes * 5 +
        cash.rollQuarters * 10 +
        cash.rollLoonies * 25 +
        cash.rollToonies * 50
    }
}


