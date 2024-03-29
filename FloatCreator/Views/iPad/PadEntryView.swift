//
//  PadEntryView.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-18.
//

import SwiftUI

struct PadEntryView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    // For iPad
    @State var activeKeyboard = false
    @State var activeNumber = ""
    @State var activeEntry: MoneyType?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 36) {
                VStack {
                    Text("Bills").font(.title3.bold())
                    Group {
                        PadEntryCell(type: .five, text: $viewModel.five, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .ten, text: $viewModel.ten, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .twenty, text: $viewModel.twenty, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .fifty, text: $viewModel.fifty, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .hundred, text: $viewModel.hundred, activeEntry: $activeEntry)
                        Spacer()
                    }
                    HStack {
                        Text("Bill Total:")
                        Spacer()
                        Text("$\(viewModel.billTotal(), specifier: "%.2f")").bold()
                    }
                    .font(.title3)
                }
                
                VStack {
                    Text("Rolls").font(.title3.bold())
                    Group {
                        PadEntryCell(type: .rollNickels, text: $viewModel.rollNickels, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .rollDimes, text: $viewModel.rollDimes, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .rollQuarters, text: $viewModel.rollQuarters, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .rollLoonies, text: $viewModel.rollLoonies, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .rollToonies, text: $viewModel.rollToonies, activeEntry: $activeEntry)
                        Spacer()
                    }
                    HStack {
                        Text("Roll Total:")
                        Spacer()
                        Text("$\(viewModel.rollTotal(), specifier: "%.2f")").bold()
                    }
                    .font(.title3)
                }
                
                VStack {
                    Text("Coins").font(.title3.bold())
                    Group {
                        PadEntryCell(type: .nickels, text: $viewModel.nickels, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .dimes, text: $viewModel.dimes, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .quarters, text: $viewModel.quarters, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .loonies, text: $viewModel.loonies, activeEntry: $activeEntry)
                        Spacer()
                        PadEntryCell(type: .toonies, text: $viewModel.toonies, activeEntry: $activeEntry)
                        Spacer()
                    }
                    HStack {
                        Text("Coin Total:")
                        Spacer()
                        Text("$\(viewModel.coinTotal(), specifier: "%.2f")").bold()
                    }
                    .font(.title3)
                }
            }
            .padding(30)
            
            Divider()
            
            HStack(alignment: .bottom, spacing: 0) {
                VStack {
                    VStack {
                        HStack {
                            Text("Till Total:")
                                .bold()
                            Spacer()
                            Text("$\(viewModel.total(), specifier: "%.2f")").bold()
                        }
                        .font(.title2)
                        
                        HStack {
                            Text("Float Amount:")
                            Spacer()
                            Text("$\(viewModel.floatAmount)")
                        }
                        .font(.title3)
                    }
                    .padding(.horizontal, 30)
                    
                    header
                }
                
                PadKeyboardView(isActive: $activeKeyboard, activeNumber: $activeNumber, width: 250)
                    .onChange(of: activeEntry) { newValue in
                        activeKeyboard = (newValue == nil ? false : true)
                        activeNumber = viewModel.existingValue(newValue: newValue)

                    }
                    .onChange(of: activeNumber) { newValue in
                        viewModel.updateNumber(newValue: newValue, activeEntry: activeEntry)
                    }
            }
            .background(Color("textfield").opacity(0.3))
        }
    }
    
    var header: some View {
            HStack {
                Button {
                    viewModel.showingList = true
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
                    Text(viewModel.date)
                        .font(.title3)
                }
                .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    viewModel.calculate()
                } label: {
                    Text("Cashout")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color("accent"))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(viewModel.total() >= Double(viewModel.floatAmount) ? Color.white : Color.white.opacity(0.5))
                        .cornerRadius(8)
                }
                .disabled(viewModel.total() < Double(viewModel.floatAmount))
                
                Button {
                    viewModel.showingClearAlert = true
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.leading, 10)
                }
                
                Button {
                    viewModel.showingSettings = true
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.leading, 8)
                }
                
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(Color("accent"))
    }
}

struct PadEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PadEntryView(viewModel: ContentViewModel())
    }
}


