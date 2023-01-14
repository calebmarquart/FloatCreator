//
//  ContentView.swift
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("float_amount") var floatAmount = 300
    
    @State var five = ""
    @State var ten = ""
    @State var twenty = ""
    @State var fifty = ""
    @State var hundred = ""
    @State var nickels = ""
    @State var dimes = ""
    @State var quarters = ""
    @State var loonies = ""
    @State var toonies = ""
    @State var rollNickels = ""
    @State var rollDimes = ""
    @State var rollQuarters = ""
    @State var rollLoonies = ""
    @State var rollToonies = ""
    
    @State var configuration: Cash = emptyCash
    @State var showingClearAlert = false
    @State var showingNextView = false
    @State var showingSettings = false
    @State var showingList = false
    
    @FocusState var focusedField: MoneyType?
    
    let date: String
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        date = formatter.string(from: Date.now)
    }
    
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        iPhoneView
                    } else {
                        iPadView
                    }
                    
                    NavigationLink(isActive: $showingNextView) {
                        FloatInfoView(configuration: configuration)
                    } label: {
                        EmptyView()
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        previousField()
                    } label: {
                        Image(systemName: "chevron.up")
                    }

                    Button {
                        nextField()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    
                    Spacer()

                    Button {
                        focusedField = nil
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showingList) {
            ListView()
        }
        .alert("Are you sure you want to clear float?", isPresented: $showingClearAlert) {
            Button("Clear", role: .destructive) {
                clearFloat()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    var iPhoneView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Money in Till")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(date).opacity(0.5)
                }
                
                Group {
                    Divider()
                    
                    Group {
                        Text("Bills")
                            .font(.headline)
                        
                        FloatCell(type: .five, text: $five, focus: _focusedField)
                        FloatCell(type: .ten, text: $ten, focus: _focusedField)
                        FloatCell(type: .twenty, text: $twenty, focus: _focusedField)
                        FloatCell(type: .fifty, text: $fifty, focus: _focusedField)
                        FloatCell(type: .hundred, text: $hundred, focus: _focusedField)
                        
                        HStack {
                            Text("Bill Total")
                            Spacer()
                            Text("$\(billTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Rolls")
                            .font(.headline)
                        FloatCell(type: .rollNickels, text: $rollNickels, focus: _focusedField)
                        FloatCell(type: .rollDimes, text: $rollDimes, focus: _focusedField)
                        FloatCell(type: .rollQuarters, text: $rollQuarters, focus: _focusedField)
                        FloatCell(type: .rollLoonies, text: $rollLoonies, focus: _focusedField)
                        FloatCell(type: .rollToonies, text: $rollToonies, focus: _focusedField)
                        HStack {
                            Text("Roll Total")
                            Spacer()
                            Text("$\(rollTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Coins")
                            .font(.headline)
                        FloatCell(type: .nickels, text: $nickels, focus: _focusedField)
                        FloatCell(type: .dimes, text: $dimes, focus: _focusedField)
                        FloatCell(type: .quarters, text: $quarters, focus: _focusedField)
                        FloatCell(type: .loonies, text: $loonies, focus: _focusedField)
                        FloatCell(type: .toonies, text: $toonies, focus: _focusedField)
                        
                        HStack {
                            Text("Coin Total")
                            Spacer()
                            Text("$\(coinTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        Divider()
                    }
                }
                HStack {
                    Text("Till Total")
                        .bold()
                    Spacer()
                    Text("$\(total(), specifier: "%.2f")")
                }
                .font(.title3)
                
                HStack {
                    Text("New Float Amount")
                    Spacer()
                    Text("$\(floatAmount)")
                }
                
                Button(action: calculate) {
                    Text("Continue")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 12)
                        .background(total() < Double(floatAmount) ? Color.secondary : Color.green)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .disabled(total() < Double(floatAmount))
            }
            .padding()
            
            
        }
        .navigationTitle("Create Float")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    showingList = true
                } label: {
                    Image(systemName: "list.bullet")
                }

            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showingClearAlert = true
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
                
            }
        }
    }
    
    var iPadView: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        showingList = true
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.trailing, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Create Float")
                            .font(.title2)
                            .bold()
                        Text(date)
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 22) {
                        Text("Till Total:").bold()
                        Text("$" + String(format: "%.2f", total())).bold()
                        
                        Button {
                            calculate()
                        } label: {
                            Text("Cashout")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.cyan)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(total() >= Double(floatAmount) ? Color.white : Color.white.opacity(0.5))
                                .cornerRadius(8)
                        }
                        .disabled(total() < Double(floatAmount))
                        
                    }
                    .foregroundColor(.white)
                    .font(.title2)
                    
                    
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.leading, 8)
                    }
                    
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
            }
            .background(Color.cyan)
            
            ScrollView {
                VStack {
                    HStack(spacing: 24) {
                        VStack {
                            Text("Bills").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .five, text: $five, focus: _focusedField)
                            FloatCell(type: .ten, text: $ten, focus: _focusedField)
                            FloatCell(type: .twenty, text: $twenty, focus: _focusedField)
                            FloatCell(type: .fifty, text: $fifty, focus: _focusedField)
                            FloatCell(type: .hundred, text: $hundred, focus: _focusedField)
                            HStack {
                                Text("Bill Total")
                                Spacer()
                                Text("$\(billTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Rolls").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .rollNickels, text: $rollNickels, focus: _focusedField)
                            FloatCell(type: .rollDimes, text: $rollDimes, focus: _focusedField)
                            FloatCell(type: .rollQuarters, text: $rollQuarters, focus: _focusedField)
                            FloatCell(type: .rollLoonies, text: $rollLoonies, focus: _focusedField)
                            FloatCell(type: .rollToonies, text: $rollToonies, focus: _focusedField)
                            HStack {
                                Text("Roll Total")
                                Spacer()
                                Text("$\(rollTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Coins").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            FloatCell(type: .nickels, text: $nickels, focus: _focusedField)
                            FloatCell(type: .dimes, text: $dimes, focus: _focusedField)
                            FloatCell(type: .quarters, text: $quarters, focus: _focusedField)
                            FloatCell(type: .loonies, text: $loonies, focus: _focusedField)
                            FloatCell(type: .toonies, text: $toonies, focus: _focusedField)
                            HStack {
                                Text("Coin Total")
                                Spacer()
                                Text("$\(coinTotal(), specifier: "%.2f")")
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding()
                    .padding(.top, 8)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
