//
//  AddFloatInfoView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-12.
//

import SwiftUI

struct AddFloatInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tillField = ""
    @State private var leadField = ""
    
    @Binding var till: String
    @Binding var lead: String
    
    let float: Cash
    let cashout: Cash
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Till", text: $tillField)
                    .textField()
                TextField("Shift Lead", text: $leadField)
                    .textField()
            }
            .navigationTitle("Float Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        till = tillField
                        lead = leadField
                        
                        CoreDataManager.instance.save(lead: lead.isEmpty ? nil : lead, till: till.isEmpty ? nil : till, float: float, cashout: cashout)
                        
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddFloatInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AddFloatInfoView(till: .constant(""), lead: .constant(""), float: emptyCash, cashout: emptyCash)
    }
}
