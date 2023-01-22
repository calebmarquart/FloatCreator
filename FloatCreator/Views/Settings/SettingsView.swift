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
                    NavigationLink("Receipt Logo") {
                        ImageSelectionView()
                    }
                }
                
                Section("About") {
                    NavigationLink("Privacy Policy") {
                        if let url = URL(string: privacyPolicy) {
                            WebView(url: url)
                                .navigationTitle("Privacy Policy")
                                .navigationBarTitleDisplayMode(.inline)
                        } else {
                            VStack {
                                Text("Hmmmm...").font(.headline)
                                Text("Something went wrong")
                            }
                        }
                    }
                    
                    NavigationLink("Terms & Conditions") {
                        if let url = URL(string: terms) {
                            WebView(url: url)
                                .navigationTitle("Terms")
                                .navigationBarTitleDisplayMode(.inline)
                        } else {
                            VStack {
                                Text("Hmmmm...").font(.headline)
                                Text("Something went wrong")
                            }
                        }
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
                        Text("\(appVersion ?? "") (\(buildVersion ?? ""))")
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

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

let privacyPolicy = "https://calebmarquart.com/float-privacy-policy/"
let terms = "https://calebmarquart.com/float-terms/"
