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
    
    let settings = StarConnectionSettings(interfaceType: .bluetooth)
    let printer: StarPrinter
    
    init() {
        self.printer = StarPrinter(settings)
    }
    
    func printFloat(with query: PrintQuery) async {
       
        // TODO: Convert the float data into a string that will be printed on a receipt
        // Use the StarPrint builder to make this
        let printCommand = buildPrintCommand(with: query)
        
        print(printCommand)
        
        do {
            try await printer.open()
            
            defer {
                Task {
                    await printer.close()
                }
            }
            
            try await printer.print(command: printCommand)
        } catch {
            print("Error printing data. \(error)")
        }
        
        
        
    }
    
    func getPrinterName() async -> String? {
        return "DEBUG PRINTER"
    }
    
    func getStatus() async -> StarPrinterStatus? {
        do {
            try await printer.open()
            
            defer {
                Task {
                    await printer.close()
                }
            }
            
            return try await printer.getStatus()
        } catch {
            print("Error with printer. \(error)")
            return nil
        }
    }
    
    private func buildPrintCommand(with query: PrintQuery) -> String {
        // Get the current date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let date = formatter.string(from: query.date)
        
        
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(
            
            StarXpandCommand.DocumentBuilder()
                .addPrinter(
                    
                    StarXpandCommand.PrinterBuilder()
                        .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: query.image, width: 406))
                        .styleInternationalCharacter(.usa)
                        .styleCharacterSpace(0)
                        .styleAlignment(.left)
                        .actionPrintText(date + "\n" + query.till + "\n" + query.lead + "\n")
                        
                        .styleBold(true)
                        .actionPrintText("Bills\n")
                        .styleBold(false)
                        .actionPrintText(
                            query.cash.five.valuePrint(.five) + "\n" +
                            query.cash.ten.valuePrint(.ten) + "\n" +
                            query.cash.twenty.valuePrint(.twenty) + "\n" +
                            query.cash.fifty.valuePrint(.fifty) + "\n" +
                            query.cash.hundred.valuePrint(.hundred) + "\n"
                        )
                        .actionFeedLine(1)
                        .actionPrintText("Bill Total: \t \(String(format: "%.2f", ChangeMaker.instance.getBillTotal(query.cash)))\n")
                    
                        .styleBold(true)
                        .actionPrintText("Coin Rolls\n")
                        .styleBold(false)
                        .actionPrintText(
                            query.cash.rollNickels.valuePrint(.rollNickels) + "\n" +
                            query.cash.rollDimes.valuePrint(.rollDimes) + "\n" +
                            query.cash.rollQuarters.valuePrint(.rollQuarters) + "\n" +
                            query.cash.rollLoonies.valuePrint(.rollLoonies) + "\n" +
                            query.cash.rollToonies.valuePrint(.rollToonies) + "\n"
                        )
                        .actionFeedLine(1)
                        .actionPrintText("Coin Roll Total: \t \(String(format: "%.2f", ChangeMaker.instance.getRollTotal(query.cash)))\n")
                    
                        .styleBold(true)
                        .actionPrintText("Coins\n")
                        .styleBold(false)
                        .actionPrintText(
                            query.cash.nickels.valuePrint(.nickels) + "\n" +
                            query.cash.dimes.valuePrint(.dimes) + "\n" +
                            query.cash.quarters.valuePrint(.quarters) + "\n" +
                            query.cash.loonies.valuePrint(.loonies) + "\n" +
                            query.cash.toonies.valuePrint(.toonies) + "\n"
                        )
                        .actionFeedLine(1)
                        .actionPrintText("Coin Total: \t \(String(format: "%.2f", ChangeMaker.instance.getCoinTotal(query.cash)))\n")
                    
                        .styleBold(true)
                        .actionPrintText("Verify\n")
                        .styleBold(false)
                        .actionPrintText(
                            "Date: _________________\n" +
                            "Discrepancy: __________\n" +
                            "Actual Total: _________\n" +
                            "Verified By: __________\n"
                        )
                        .actionCut(.partial)
                    )
            )
        
        return builder.getCommands()
    }
}

struct PrintQuery: Identifiable {
    let id = UUID()
    let cash: Cash
    let till: String
    let lead: String
    let date: Date
    let image: UIImage
}
