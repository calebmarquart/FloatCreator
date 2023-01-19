//
//  AddFloatInfoView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct FloatInfoView: View {
    @AppStorage("image_data") private var imageData = Data()
    
    @State private var till = ""
    @State private var lead = ""
    
    @State private var float: PrintQuery = previewQuery
    @State private var cashout: PrintQuery = previewQuery
    
    @State private var showingDetail = false
    
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
                        TextField("Till", text: $till)
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
                        TextField("Shift Lead", text: $lead)
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
                
                Button(action: createFloat) {
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
                
                Spacer()
            }
        .padding(.vertical)
        .padding(.horizontal, 30)
        .navigationTitle("Float Info")
        .navigationDestination(isPresented: $showingDetail) {
            if UIDevice.current.userInterfaceIdiom == .phone {
                // PhoneSingleView
                PhoneSingleView(float: float, cashout: cashout)
            } else {
                // PadDualView
                PadDualView(float: float, cashout: cashout)
            }
        }
    }
    
    private func createFloat() {
        let cashout = ChangeMaker.instance.createCashout(from: configuration)
        let float = ChangeMaker.instance.createFloat(original: configuration, cashout: cashout)
        
        let lead = self.lead.isEmpty ? "Anonymous" : self.lead
        let till = self.till.isEmpty ? "Any Till" : self.till
        let date = Date.now
        let image = imageData.toImage()
        
        self.float = PrintQuery(type: .float, cash: float, till: till, lead: lead, date: date, image: image)
        
        self.cashout = PrintQuery(type: .cashout, cash: cashout, till: till, lead: lead, date: date, image: image)
        
        CoreDataManager.instance.save(lead: lead.isEmpty ? nil : lead, till: till.isEmpty ? nil : till, float: float, cashout: cashout)
        
        showingDetail = true
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
