//
//  AddFloatInfoView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct FloatInfoView: View {
    
    @StateObject var viewModel = FloatInfoViewModel()
    
    @FocusState private var focusedField: Field?
    
    let configuration: Cash
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Till Amount: $" + String(format: "%.2f", ChangeMaker.instance.getTotal(configuration)))
                .font(.headline)
            
            Text("Before the float is created let's get the till and the name of the shift lead so we know who made this float.")
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "dollarsign.circle").foregroundColor(.secondary)
                    TextField("Till", text: $viewModel.till)
                        .focused($focusedField, equals: .till)
                        .onSubmit {
                            focusedField = .lead
                        }
                        .submitLabel(.next)
                }
                .padding()
                .background(Color("textfield"))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 6, x: 3, y: 3)
                
                HStack {
                    Image(systemName: "person").foregroundColor(.secondary)
                    TextField("Shift Lead", text: $viewModel.lead)
                        .focused($focusedField, equals: .lead)
                        .onSubmit {
                            focusedField = nil
                        }
                        .submitLabel(.done)
                }
                .padding()
                .background(Color("textfield"))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 6, x: 3, y: 3)
            }
            .font(.subheadline)
            
            Button {
                viewModel.createFloat(with: configuration)
            } label: {
                Text("Create Float")
                    .bold()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 36)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(12)
                    .font(.title3)
            }
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .center)
            
            NavigationLink(destination: navigationDestination(), isActive: $viewModel.showingDetail) {
                EmptyView()
            }
            
            Spacer()
        }
        .padding(.vertical)
        .padding(.horizontal, 30)
        .navigationTitle("Float Info")
    }
    
    @ViewBuilder func navigationDestination() -> some View {
        if UIDevice.current.isPhone() {
            PhoneSingleView(float: viewModel.float, cashout: viewModel.cashout)
        } else {
            PadDualView(float: viewModel.float, cashout: viewModel.cashout)
        }
    }
    
    private enum Field: Hashable {
        case till
        case lead
    }
}

struct AddFloatInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FloatInfoView(configuration: emptyCash)
        }
    }
}
