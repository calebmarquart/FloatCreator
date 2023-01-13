//
//  ListView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("image_data") private var imageData = Data()
    @State private var floats = [FloatDB]()
    
    var body: some View {
        NavigationView {
            List(floats) { item in
                NavigationLink {
                   makeDestination(with: item)
                } label: {
                    makeLabel(with: item)
                }
            }
            .task {
                floats = await CoreDataManager.instance.fetch()
            }
            .navigationTitle("Saved Floats")
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
    }
    
    @ViewBuilder func makeDestination(with item: FloatDB) -> some View {
        let floatQuery = PrintQuery(type: .float, cash: item.float.unwrap(), till: item.till ?? "Any", lead: item.lead ?? "Anonymous", date: item.date ?? Date.now, image: imageData.toImage())
        
        let cashoutQuery = PrintQuery(type: .cashout, cash: item.cashout.unwrap(), till: item.till ?? "Any", lead: item.lead ?? "Anonymous", date: item.date ?? Date.now, image: imageData.toImage())
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            SaveBridgeView(floatPrint: floatQuery, cashoutPrint: cashoutQuery)
        } else {
            SaveFloatView(floatPrint: floatQuery, cashoutPrint: cashoutQuery)
        }
    }
    
    @ViewBuilder func makeLabel(with item: FloatDB) -> some View {
        VStack(alignment: .leading) {
            Text((item.date ?? Date.now).regularText())
                .font(.headline)
            Text("Till: \(item.till ?? "Any")")
                .foregroundColor(.secondary)
            Text("Shift Lead: \(item.lead ?? "Anonymous")")
                .foregroundColor(.secondary)
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


