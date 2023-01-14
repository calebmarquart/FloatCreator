//
//  PrintManager.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-09.
//

import SwiftUI
import StarIO10

class PrintManager {
    
    static let instance = PrintManager()
    
    let printer: StarPrinter = StarPrinter(StarConnectionSettings(interfaceType: .bluetooth))
    
    func printFloat(with query: PrintQuery) async {
        
        // Create the print command from the builder
        let printCommand = buildPrintCommand(with: query)
        
        do {
            // Open access to the print
            try await printer.open()
            
            defer {
                Task {
                    // Close the printer before exiting the function
                    await printer.close()
                }
            }
            // Print the command
            try await printer.print(command: printCommand)
            
        } catch {
            print("Error printing data. \(error)")
        }
    }
    
    func isConnected() async -> Bool {
        do {
            try await printer.open()
            
            defer {
                Task {
                    await printer.close()
                }
            }
            
            _ = try await printer.getStatus()
            
            return true
        } catch {
            return false
        }
    }
    
    private func buildPrintCommand(with query: PrintQuery) -> String {
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
                        .add(buildSection(section: .bills, cash: query.cash))
                        .add(buildSection(section: .rolls, cash: query.cash))
                        .add(buildSection(section: .coins, cash: query.cash))
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
                .styleAlignment(.left)
                .styleBold(true)
                .actionPrintText("\tBills\n")
                .styleBold(false)
                .actionPrintText(
                    cash.five.valuePrint(.five) + "\n" +
                    cash.ten.valuePrint(.ten) + "\n" +
                    cash.twenty.valuePrint(.twenty) + "\n" +
                    cash.fifty.valuePrint(.fifty) + "\n" +
                    cash.hundred.valuePrint(.hundred) + "\n"
                )
                .actionPrintText("\tBill Total: \t $\(String(format: "%.2f", ChangeMaker.instance.getBillTotal(cash)))\n")
                .actionFeedLine(1)
        case .rolls:
            return StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("\tRolls\n")
                .styleBold(false)
                .actionPrintText(
                    cash.rollNickels.valuePrint(.rollNickels) + "\n" +
                    cash.rollDimes.valuePrint(.rollDimes) + "\n" +
                    cash.rollQuarters.valuePrint(.rollQuarters) + "\n" +
                    cash.rollLoonies.valuePrint(.rollLoonies) + "\n" +
                    cash.rollToonies.valuePrint(.rollToonies) + "\n"
                )
                .actionPrintText(
                    "\tRoll Total: \t $\(String(format: "%.2f", ChangeMaker.instance.getRollTotal(cash)))\n"
                )
                .actionFeedLine(1)
        case .coins:
            return StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("\tCoins\n")
                .styleBold(false)
                .actionPrintText(
                    cash.nickels.valuePrint(.nickels) + "\n" +
                    cash.dimes.valuePrint(.dimes) + "\n" +
                    cash.quarters.valuePrint(.quarters) + "\n" +
                    cash.loonies.valuePrint(.loonies) + "\n" +
                    cash.toonies.valuePrint(.toonies) + "\n"
                )
                .actionPrintText("\tCoin Total: \t $\(String(format: "%.2f", ChangeMaker.instance.getCoinTotal(cash)))\n")
                .actionFeedLine(1)
        }
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
    
    private enum SectionType {
        case rolls
        case coins
        case bills
    }
}
