//
//  PhoneEntryView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

struct PhoneEntryView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    @FocusState var focusedField: MoneyType?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Money in Till")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(viewModel.date).opacity(0.5)
                }
                
                Group {
                    Divider()
                    
                    Group {
                        Text("Bills")
                            .font(.headline)
                        
                        PhoneEntryCell(type: .five, text: $viewModel.five, focus: _focusedField)
                        PhoneEntryCell(type: .ten, text: $viewModel.ten, focus: _focusedField)
                        PhoneEntryCell(type: .twenty, text: $viewModel.twenty, focus: _focusedField)
                        PhoneEntryCell(type: .fifty, text: $viewModel.fifty, focus: _focusedField)
                        PhoneEntryCell(type: .hundred, text: $viewModel.hundred, focus: _focusedField)
                        
                        HStack {
                            Text("Bill Total")
                            Spacer()
                            Text("$\(viewModel.billTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Rolls")
                            .font(.headline)
                        PhoneEntryCell(type: .rollNickels, text: $viewModel.rollNickels, focus: _focusedField)
                        PhoneEntryCell(type: .rollDimes, text: $viewModel.rollDimes, focus: _focusedField)
                        PhoneEntryCell(type: .rollQuarters, text: $viewModel.rollQuarters, focus: _focusedField)
                        PhoneEntryCell(type: .rollLoonies, text: $viewModel.rollLoonies, focus: _focusedField)
                        PhoneEntryCell(type: .rollToonies, text: $viewModel.rollToonies, focus: _focusedField)
                        HStack {
                            Text("Roll Total")
                            Spacer()
                            Text("$\(viewModel.rollTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        
                        Divider()
                    }
                    
                    Group {
                        Text("Coins")
                            .font(.headline)
                        PhoneEntryCell(type: .nickels, text: $viewModel.nickels, focus: _focusedField)
                        PhoneEntryCell(type: .dimes, text: $viewModel.dimes, focus: _focusedField)
                        PhoneEntryCell(type: .quarters, text: $viewModel.quarters, focus: _focusedField)
                        PhoneEntryCell(type: .loonies, text: $viewModel.loonies, focus: _focusedField)
                        PhoneEntryCell(type: .toonies, text: $viewModel.toonies, focus: _focusedField)
                        
                        HStack {
                            Text("Coin Total")
                            Spacer()
                            Text("$\(viewModel.coinTotal(), specifier: "%.2f")")
                        }
                        .font(.subheadline)
                        Divider()
                    }
                }
                HStack {
                    Text("Till Total")
                        .bold()
                    Spacer()
                    Text("$\(viewModel.total(), specifier: "%.2f")")
                }
                .font(.title3)
                
                HStack {
                    Text("New Float Amount")
                    Spacer()
                    Text("$\(viewModel.floatAmount)")
                }
                
                Button(action: viewModel.calculate) {
                    Text("Continue")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 12)
                        .background(viewModel.total() < Double(viewModel.floatAmount) ? Color.secondary : Color.green)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .disabled(viewModel.total() < Double(viewModel.floatAmount))
            }
            .padding()
            
            
        }
        .navigationTitle("Create Float")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    viewModel.showingList = true
                } label: {
                    Image(systemName: "list.bullet")
                }

            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showingClearAlert = true
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
                Button {
                    viewModel.showingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
            }
            
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
    
    private func previousField() {
        guard let field = focusedField else { return }
        
        // Set the focused field to the previous one in the list
        switch field {
        case .nickels: focusedField = .rollToonies
        case .dimes: focusedField = .nickels
        case .quarters: focusedField = .dimes
        case .loonies: focusedField = .quarters
        case .toonies: focusedField = .loonies
        case .rollNickels: focusedField = .hundred
        case .rollDimes: focusedField = .rollNickels
        case .rollQuarters: focusedField = .rollDimes
        case .rollLoonies: focusedField = .rollQuarters
        case .rollToonies: focusedField = .rollLoonies
        case .five: focusedField = nil
        case .ten: focusedField = .five
        case .twenty: focusedField = .ten
        case .fifty: focusedField = .twenty
        case .hundred: focusedField = .fifty
        }
    }
    
    private func nextField() {
        guard let field = focusedField else { return }
        
        // Set the focuses field to the next one in the list
        switch field {
        case .nickels: focusedField = .dimes
        case .dimes: focusedField = .quarters
        case .quarters: focusedField = .loonies
        case .loonies: focusedField = .toonies
        case .toonies: focusedField = nil
        case .rollNickels: focusedField = .rollDimes
        case .rollDimes: focusedField = .rollQuarters
        case .rollQuarters: focusedField = .rollLoonies
        case .rollLoonies: focusedField = .rollToonies
        case .rollToonies: focusedField = .nickels
        case .five: focusedField = .ten
        case .ten: focusedField = .twenty
        case .twenty: focusedField = .fifty
        case .fifty: focusedField = .hundred
        case .hundred: focusedField = .rollNickels
        }
    }
}

struct PhoneEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneEntryView(viewModel: ContentViewModel())
    }
}
