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
    
    let builder = PrintBuilder()
    
    let printer: StarPrinter = StarPrinter(StarConnectionSettings(interfaceType: .bluetooth))
    
    func printFloat(with query: PrintQuery) async {
        
        // Create the print command from the builder
        let printContent = builder.buildPrintFeed(with: query)
        
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
            try await printer.print(command: printContent)
            
        } catch {
            print("Error printing data. \(error)")
        }
    }
    
    func printerConnectionStatus() async -> PrinterConnectionStatus {
        do {
            try await printer.open()
            
            defer {
                Task {
                    await printer.close()
                }
            }
            
            let status = try await printer.getStatus()
            guard !status.paperEmpty else { return .outOfPaper }
            guard !status.hasError else { return .unknownError }
            
            return .connected
            
        } catch {
            return .notConnected
        }
    }
    
}

enum PrinterConnectionStatus {
    case connected
    case connecting
    case notConnected
    case outOfPaper
    case unknownError
}
