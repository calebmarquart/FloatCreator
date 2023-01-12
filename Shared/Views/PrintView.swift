//
//  PrintView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-09.
//

import SwiftUI

struct PrintView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var shiftLead = ""
    @State private var till = ""
    @State private var printerName: String?
    @State private var printing = false
    
    let cash: Cash
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                if let name = printerName {
                    Text("Connected Printer: \(name)")
                        .font(.headline)
                    TextField("Till", text: $till)
                        .textField()
                    TextField("Shift Lead", text: $shiftLead)
                        .textField()
                    
                    Button {
                        let query = PrintQuery(cash: cash, till: till, lead: shiftLead, date: Date.now, image: UIImage(named: "logo")!)
                        
                        // TODO: Call the print function
                        printing = true

                        Task {
                            await PrintManager.instance.printFloat(with: query)
                        }

                        printing = false
                        
                        dismiss()
                        
                    } label: {
                        Text("Print")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(printing ? Color.gray : Color.cyan)
                            .cornerRadius(15)
                            .disabled(printing)
                    }

                    Spacer()
                    
                } else {
                    Text("There are no connected printers")
                        .font(.headline)
                    Text("Please add a bluetooth printer from the device settings")
                        .font(.caption)
                }
            }
            .padding()
            .navigationTitle("Print Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .task {
                printerName = await PrintManager.instance.getPrinterName()
            }
        }
    }
    
}

struct PrintView_Previews: PreviewProvider {
    static var previews: some View {
        PrintView(cash: emptyCash)
    }
}
