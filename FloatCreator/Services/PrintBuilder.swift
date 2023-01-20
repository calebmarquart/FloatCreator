//
//  PrintBuilder.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-20.
//

import SwiftUI
import StarIO10

class PrintBuilder {
    
    func buildPrintFeed(with query: PrintQuery) -> String {
        // Get the current date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let date = formatter.string(from: query.date)
        // Get the float type name
        let floatName = query.type.string()
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(
            StarXpandCommand.DocumentBuilder()
                .addPrinter(
                    StarXpandCommand.PrinterBuilder()
                        .add(buildHeader(name: floatName, date: date, till: query.till, lead: query.lead, image: query.image))
                        .styleAlignment(.left)
                        .add(buildSection(section: .bills, cash: query.cash))
                        .add(buildSection(section: .rolls, cash: query.cash))
                        .add(buildSection(section: .coins, cash: query.cash))
                        .add(buildTotal(title: floatName, cash: query.cash))
                        .add(buildVerify())
                    )
            )
        
        return builder.getCommands()
    }
    
    
    private func buildHeader(name: String, date: String, till: String, lead: String, image: UIImage?) -> StarXpandCommand.PrinterBuilder {
        
        if let image = image {
            return StarXpandCommand.PrinterBuilder()
                .styleAlignment(.center)
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: image, width: 350))
                .styleInternationalCharacter(.usa)
                .styleCharacterSpace(0)
                .actionFeedLine(1)
                .styleBold(true)
                .actionPrintText(name + " Receipt\n")
                .styleBold(false)
                .actionPrintText(date + "\n" + till + " | " + lead)
                .actionFeedLine(1)
        } else {
            return StarXpandCommand.PrinterBuilder()
                .styleAlignment(.center)
                .styleInternationalCharacter(.usa)
                .styleCharacterSpace(0)
                .actionFeedLine(1)
                .styleBold(true)
                .actionPrintText(name + " Receipt\n")
                .styleBold(false)
                .actionPrintText(date + "\n" + till + " | " + lead)
                .actionFeedLine(1)
        }
    }
    
    private func buildSection(section: SectionType, cash: Cash) -> StarXpandCommand.PrinterBuilder {
        switch section {
        case .bills:
            return StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("\tBills\n")
                .styleBold(false)
                .actionPrintText(
                    buildLineString(amount: cash.five, type: .five) +
                    buildLineString(amount: cash.ten, type: .ten) +
                    buildLineString(amount: cash.twenty, type: .twenty) +
                    buildLineString(amount: cash.fifty, type: .five) +
                    buildLineString(amount: cash.hundred, type: .hundred)
                )
                .actionPrintText("\tBill Total: \t $\(String(format: "%.2f", ChangeMaker.instance.getBillTotal(cash)))\n")
                .actionFeedLine(1)
        case .rolls:
            return StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("\tRolls\n")
                .styleBold(false)
                .actionPrintText(
                    buildLineString(amount: cash.rollNickels, type: .rollNickels) +
                    buildLineString(amount: cash.rollDimes, type: .rollDimes) +
                    buildLineString(amount: cash.rollQuarters, type: .rollQuarters) +
                    buildLineString(amount: cash.rollLoonies, type: .rollLoonies) +
                    buildLineString(amount: cash.rollToonies, type: .rollToonies)
                )
                .actionPrintText(
                    "\tRoll Total: \t $\(ChangeMaker.instance.getRollTotal(cash)))\n"
                )
                .actionFeedLine(1)
        case .coins:
            return StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("\tCoins\n")
                .styleBold(false)
                .actionPrintText(
                    buildLineString(amount: cash.nickels, type: .nickels) +
                    buildLineString(amount: cash.dimes, type: .dimes) +
                    buildLineString(amount: cash.quarters, type: .quarters) +
                    buildLineString(amount: cash.loonies, type: .loonies) +
                    buildLineString(amount: cash.toonies, type: .toonies)
                )
                .actionPrintText("\tCoin Total: \t $\(String(format: "%.2f", ChangeMaker.instance.getCoinTotal(cash)))\n")
                .actionFeedLine(1)
        }
    }
    
    private func buildTotal(title: String, cash: Cash) -> StarXpandCommand.PrinterBuilder {
        return StarXpandCommand.PrinterBuilder()
            .styleBold(true)
            .actionPrintText("\t" + title + " Total\n")
            .styleBold(false)
            .actionPrintText("\t$" + String(format: "%.2f", ChangeMaker.instance.getTotal(cash)))
            .actionFeedLine(1)
    }
    
    private func buildVerify() -> StarXpandCommand.PrinterBuilder {
        return StarXpandCommand.PrinterBuilder()
            .styleAlignment(.center)
            .styleBold(true)
            .actionPrintText("Verify")
            .styleBold(false)
            .actionFeedLine(1)
            .actionPrintText(
                "Date: ______________________\n\n" +
                "Discrepancy: _______________\n\n" +
                "Actual Total: ______________\n\n" +
                "Verified By: _______________\n\n"
            )
            .actionCut(.partial)
    }
    
    private func buildLineString(amount: Int, type: MoneyType) -> String {
        var string = "\t" // String starts with tab offset
        string += "(\(type.symbol()))" // Get the symbol in parenthesis
        string += " \(amount) x $" // Add the amount with a space and $ sign
        string += type.multiplier() // Add the multiplier
        string += " \t $" // Add a tab offset and $ sign
        string += type.valueString(amount) // Add the value
        string += "\n" // New line
        
        return string
    }
    
    private enum SectionType {
        case rolls
        case coins
        case bills
    }
    
}
