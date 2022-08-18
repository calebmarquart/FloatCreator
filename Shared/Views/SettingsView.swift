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
    
    var body: some View {
        List {
            Section("Float Amount") {
                Stepper("$\(floatAmount) Float", value: $floatAmount, in: 50...1000, step: 50)
            }
            
            Section("About") {
                NavigationLink("Privacy Policy") {
                    Text("Privacy Policy")
                }
                
                NavigationLink("Terms & Conditions") {
                    Text("Terms & Conditions")
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
