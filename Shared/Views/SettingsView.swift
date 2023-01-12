//
//  SettingsView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-17.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("float_amount") var floatAmount = 300
    @AppStorage("show_images") var showImages = true
    
    var body: some View {
        NavigationView {
            List {
                Section("Float Amount") {
                    Stepper("$\(floatAmount) Float", value: $floatAmount, in: 50...1000, step: 50)
                }
                
                Section("Images") {
                    Toggle("Show Images", isOn: $showImages)
                }
                
                Section("About") {
                    NavigationLink("Privacy Policy") {
                        WebView(url: URL(string: "https://calebmarquart.com/floatcreator/privacy-policy/")!)
                    }
                    
                    NavigationLink("Terms & Conditions") {
                        WebView(url: URL(string: "https://calebmarquart.com/floatcreator/terms/")!)
                    }
                    
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Caleb Marquart")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.secondary)
                    }
                    
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
