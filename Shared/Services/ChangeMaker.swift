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
        var five = 0
        var ten = 0
        var twenty = 0
        var fifty = 0
        var hundred = 0
        
        // 100 Bills
        if configuration.hundred != 0 {
            let maxBill100 = Int(total / Double(100))
            if configuration.hundred <= maxBill100 {
                total -= Double(configuration.hundred * 100)
                hundred = configuration.hundred
            } else {
                total -= Double(maxBill100 * 100)
                hundred = maxBill100
            }
        }
        
        // 50 Bills
        if configuration.fifty != 0 {
            let maxBill50 = Int(total / Double(50))
            if configuration.fifty <= maxBill50 {
                total -= Double(configuration.fifty * 50)
                fifty = configuration.fifty
            } else {
                total -= Double(maxBill50 * 50)
                fifty = maxBill50
            }
        }
        
        // 20 Bills
        if configuration.twenty != 0 {
            let maxBill20 = Int(total / Double(20))
            if configuration.twenty <= maxBill20 {
                total -= Double(configuration.twenty * 20)
                twenty = configuration.twenty
            } else {
                total -= Double(maxBill20 * 20)
                twenty = maxBill20
            }
        }
        
        // 10 Bill
        if configuration.ten != 0 {
            let maxBill10 = Int(total / Double(10))
            if configuration.ten <= maxBill10 {
                total -= Double(configuration.ten * 10)
                ten = configuration.ten
            } else {
                total -= Double(maxBill10 * 10)
                ten = maxBill10
            }
        }
        
        // 5 Bill
        if configuration.five != 0 {
            let maxBill5 = Int(total / Double(5))
            if configuration.five <= maxBill5 {
                total -= Double(configuration.five * 5)
                five = configuration.five
            } else {
                total -= Double(maxBill5 * 5)
                five = maxBill5
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
                    five: five,
                    ten: ten,
                    twenty: twenty,
                    fifty: fifty,
                    hundred: hundred
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
        return cash.five * 5 +
        cash.ten * 10 +
        cash.twenty * 20 +
        cash.fifty * 50 +
        cash.hundred * 100
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
    let five: Int
    let ten: Int
    let twenty: Int
    let fifty: Int
    let hundred: Int
}
