//
//  Model.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-08.
//

import SwiftUI

struct Cash: Identifiable {
    let id = UUID()
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

enum MoneyType {
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


let emptyCash = Cash(dimes: 0, nickels: 0, quarters: 0, loonies: 0, toonies: 0, rollNickels: 0, rollDimes: 0, rollQuarters: 0, rollLoonies: 0, rollToonies: 0, five: 0, ten: 0, twenty: 0, fifty: 0, hundred: 0)
