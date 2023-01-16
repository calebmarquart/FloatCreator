//
//  CoreDataManager.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FloatStorage")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading the database. \(error)")
            }
        }
    }
    
    func save(lead: String?, till: String?, float: Cash, cashout: Cash) {
        
        let entry = FloatDB(context: container.viewContext)
        entry.date = Date.now
        entry.lead = lead
        entry.till = till
        entry.cashout = makeCash(with: float)
        entry.float = makeCash(with: cashout)
        
        save()
    }
    
    func fetch() async -> [FloatDB] {
        let request = NSFetchRequest<FloatDB>(entityName: "FloatDB")
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateSort]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching data. \(error)")
            return []
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving the context. \(error)")
        }
    }
    
    private func makeCash(with cash: Cash) -> CashDB {
        let entry = CashDB(context: container.viewContext)
        entry.nickels = Int16(cash.nickels)
        entry.dimes = Int16(cash.dimes)
        entry.quarters = Int16(cash.quarters)
        entry.loonies = Int16(cash.loonies)
        entry.toonies = Int16(cash.toonies)
        entry.rollNickels = Int16(cash.rollNickels)
        entry.rollDimes = Int16(cash.rollDimes)
        entry.rollQuarters = Int16(cash.rollQuarters)
        entry.rollLoonies = Int16(cash.rollLoonies)
        entry.rollToonies = Int16(cash.rollToonies)
        entry.five = Int16(cash.five)
        entry.ten = Int16(cash.ten)
        entry.twenty = Int16(cash.twenty)
        entry.fifty = Int16(cash.fifty)
        entry.hundred = Int16(cash.hundred)
        
        return entry
    }
}



extension CashDB? {
    func unwrap() -> Cash {
        guard let cash = self else { return emptyCash }
        return Cash(dimes: Int(cash.dimes), nickels: Int(cash.nickels), quarters: Int(cash.quarters), loonies: Int(cash.loonies), toonies: Int(cash.toonies), rollNickels: Int(cash.rollNickels), rollDimes: Int(cash.rollDimes), rollQuarters: Int(cash.rollQuarters), rollLoonies: Int(cash.rollLoonies), rollToonies: Int(cash.rollToonies), five: Int(cash.five), ten: Int(cash.ten), twenty: Int(cash.twenty), fifty: Int(cash.fifty), hundred: Int(cash.hundred))
    }
}
