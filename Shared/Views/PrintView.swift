//
//  PrintView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-09.
//

import SwiftUI

struct PrintView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var connection: ConnectionState = .connecting
    
    let print: PrintQuery
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                switch connection {
                case .connecting: connecting
                case .connected: connected
                case .notConnected: notConnected
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
                let isConnected = await PrintManager.instance.isConnected()
                connection = isConnected ? .connected : .notConnected
            }
        }
    }
    
    var connecting: some View {
        Group {
            Text("Looking for printers...")
            ProgressView()
        }
    }
    
    var notConnected: some View {
        Group {
            Text("There are no connected printers")
                .font(.headline)
            Text("Please add a bluetooth printer from the device settings")
                .font(.caption)
        }
    }
    
    var connected: some View {
        Group {
            HStack {
                Text("Printer Connected")
                Image(systemName: "check.circle.fill")
                    .foregroundColor(.green)
            }
            
            Button {
                Task {
                    await PrintManager.instance.printFloat(with: print)
                }
                
                dismiss()
            } label: {
                Text("Print")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(Color.cyan)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
    }
    
    private enum ConnectionState {
        case connected
        case connecting
        case notConnected
    }
    
}
