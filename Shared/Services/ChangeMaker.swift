//
//  ChangeMaker.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct ChangeMaker {
    func createCashout(from configuration: Cash, float: Int) -> Cash {
        var total = getTotal(configuration) - Double(float)
        
        var nickels = 0
        var dimes = 0
        var quarters = 0
        var loonies = 0
        var toonies = 0
        var bill5 = 0
        var bill10 = 0
        var bill20 = 0
        var bill50 = 0
        var bill100 = 0
        
        // 100 Bills
        if configuration.bill100 != 0 {
            let maxBill100 = Int(total / Double(100))
            if configuration.bill100 <= maxBill100 {
                total -= Double(configuration.bill100 * 100)
                bill100 = configuration.bill100
            } else {
                total -= Double(100)
                bill100 = maxBill100
            }
        }
        
        // 50 Bills
        if configuration.bill50 != 0 {
            let maxBill50 = Int(total / Double(50))
            if configuration.bill50 <= maxBill50 {
                total -= Double(configuration.bill50 * 50)
                bill50 = configuration.bill50
            } else {
                total -= Double(maxBill50 * 50)
                bill50 = maxBill50
            }
        }
        
        // 20 Bills
        if configuration.bill20 != 0 {
            let maxBill20 = Int(total / Double(20))
            if configuration.bill20 <= maxBill20 {
                total -= Double(configuration.bill20 * 20)
                bill20 = configuration.bill20
            } else {
                total -= Double(maxBill20 * 20)
                bill20 = maxBill20
            }
        }
        
        // 10 Bill
        if configuration.bill10 != 0 {
            let maxBill10 = Int(total / Double(10))
            if configuration.bill10 <= maxBill10 {
                total -= Double(configuration.bill10 * 10)
                bill10 = configuration.bill10
            } else {
                total -= Double(maxBill10 * 10)
                bill10 = maxBill10
            }
        }
        
        // 5 Bill
        if configuration.bill5 != 0 {
            let maxBill5 = Int(total / Double(5))
            if configuration.bill5 <= maxBill5 {
                total -= Double(configuration.bill5 * 5)
                bill5 = configuration.bill5
            } else {
                total -= Double(maxBill5 * 5)
                bill5 = maxBill5
            }
        }
        
        // Toonies
        if configuration.toonies != 0 {
            let maxToonies = Int(total / Double(2))
            if configuration.toonies <= maxToonies {
                total -= Double(configuration.toonies * 2)
                toonies = configuration.toonies
            } else {
                total -= Double(maxToonies * 2)
                toonies = maxToonies
            }
        }
        
        // Loonies
        if configuration.loonies != 0 {
            let maxLoonies = Int(total / Double(1))
            if configuration.loonies <= maxLoonies {
                total -= Double(configuration.loonies * 1)
                loonies = configuration.loonies
            } else {
                total -= Double(maxLoonies * 1)
                loonies = maxLoonies
            }
        }
        
        // Quarters
        if configuration.quarters != 0 {
            let maxQuarters = Int(total / 0.25)
            if configuration.quarters <= maxQuarters {
                total -= Double(configuration.quarters) * 0.25
                quarters = configuration.quarters
            } else {
                total -= Double(maxQuarters) * 0.25
                quarters = maxQuarters
            }
        }
        
        // Dimes
        if configuration.dimes != 0 {
            let maxDimes = Int(Float(total / 0.1))
            if configuration.dimes <= maxDimes {
                total -= Double(configuration.dimes) * 0.1
                dimes = configuration.dimes
            } else {
                total -= Double(maxDimes) * 0.1
                dimes = maxDimes
            }
        }
        
        // Nickels
        if configuration.nickels != 0 {
            let maxNickels = Int(Float(total / 0.05))
            if configuration.nickels <= maxNickels {
                total -= Double(configuration.nickels) * 0.05
                nickels = configuration.nickels
            } else {
                total -= Double(maxNickels) * 0.05
                nickels = maxNickels
            }
        }
        
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
                    bill5: bill5,
                    bill10: bill10,
                    bill20: bill20,
                    bill50: bill50,
                    bill100: bill100
        )
    }
    
    func createFloat(original: Cash, cashout: Cash) -> Cash {
        let dimes = original.dimes - cashout.dimes
        let nickels = original.nickels - cashout.nickels
        let quarters = original.quarters - cashout.quarters
        let loonies = original.loonies - cashout.loonies
        let toonies = original.toonies - cashout.toonies
        let rollNickels = original.rollNickels
        let rollDimes = original.rollDimes
        let rollQuarters = original.rollDimes
        let rollLoonies = original.rollLoonies
        let rollToonies = original.rollToonies
        let bill5 = original.bill5 - cashout.bill5
        let bill10 = original.bill10 - cashout.bill10
        let bill20 = original.bill20 - cashout.bill20
        let bill50 = original.bill50 - cashout.bill50
        let bill100 = original.bill100 - cashout.bill100
        
        return Cash(dimes: dimes, nickels: nickels, quarters: quarters, loonies: loonies, toonies: toonies, rollNickels: rollNickels, rollDimes: rollDimes, rollQuarters: rollQuarters, rollLoonies: rollLoonies, rollToonies: rollToonies, bill5: bill5, bill10: bill10, bill20: bill20, bill50: bill50, bill100: bill100)
        
    }
    
    func getTotal(_ cash: Cash) -> Double {
        return getCoinTotal(cash) + Double(getRollTotal(cash)) + Double(getBillTotal(cash))
    }
    
    func getCoinTotal(_ cash: Cash) -> Double {
        return Double(cash.nickels) * 0.05 +
        Double(cash.dimes) * 0.1 +
        Double(cash.quarters) * 0.25 +
        Double(cash.loonies) +
        Double(cash.toonies) * 2
    }
    
    func getBillTotal(_ cash: Cash) -> Int {
        return cash.bill5 * 5 +
        cash.bill10 * 10 +
        cash.bill20 * 20 +
        cash.bill50 * 50 +
        cash.bill100 * 100
    }
    
    func getRollTotal(_ cash: Cash) -> Int {
        return cash.rollNickels * 2 +
        cash.rollDimes * 5 +
        cash.rollQuarters * 10 +
        cash.rollLoonies * 25 +
        cash.rollToonies * 50
    }
}

struct Cash {
    let dimes: Int
    let nickels: Int
    let quarters: Int
    let loonies: Int
    let toonies: Int
    let rollNickels: Int
    let rollDimes: Int
    let rollQuarters: Int
    let rollLoonies: Int
    let rollToonies: Int
    let bill5: Int
    let bill10: Int
    let bill20: Int
    let bill50: Int
    let bill100: Int
}
