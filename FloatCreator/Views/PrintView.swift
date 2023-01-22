//
//  PrintView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-09.
//

import SwiftUI

struct PrintView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var connection: PrinterConnectionStatus = .connecting
    
    let print: PrintQuery
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                switch connection {
                case .connecting: connecting
                case .notConnected: notConnected
                default: connected
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
                connection = await PrintManager.instance.printerConnectionStatus()
            }
        }
    }
    
    var connecting: some View {
        Group {
            Text("Looking for printers...")
            ProgressView()
        }
        .offset(y: -50)
    }
    
    var notConnected: some View {
        Group {
            Text("There are no connected printers")
                .font(.headline)
            Text("Please add a bluetooth printer from the device settings")
                .font(.caption)
        }
        .offset(y: -50)
    }
    
    var connected: some View {
        Group {
            switch connection {
            case .outOfPaper:
                HStack {
                    Image(systemName: "paperclip")
                        .foregroundColor(.orange)
                    Text("Printer Connected")
                }
                .font(.title3)
            case .unknownError:
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("Printer Connected")
                }
                .font(.title3)
            default:
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Printer Connected")
                }
                .font(.title3)
            }
            
            Button {
                Task {
                    await PrintManager.instance.printFloat(with: print)
                }
                
                dismiss()
            } label: {
                Label("Print", systemImage: "printer")
                    .foregroundColor(.white)
                    .font(.title3.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(Color("accent"))
                    .cornerRadius(12)
            }
            
            Spacer()
        }
    }
}

struct PrintViewPreviews: PreviewProvider {
    static var previews: some View {
        PrintView(print: previewQuery)
    }
}
