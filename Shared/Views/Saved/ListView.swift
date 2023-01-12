//
//  ListView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var floats = [FloatDB]()
    
    var body: some View {
        NavigationView {
            List(floats) { item in
                NavigationLink {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        SaveBridgeView(float: item.float.unwrap(), cashout: item.cashout.unwrap())
                            .navigationTitle(item.date?.regularText() ?? "No Date")
                    } else {
                        SaveDetailView(float: item.float.unwrap(), cashout: item.cashout.unwrap())
                            .navigationTitle(item.date?.regularText() ?? "No Date")
                    }
                        
                } label: {
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
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


