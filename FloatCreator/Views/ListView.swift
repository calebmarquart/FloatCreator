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
        NavigationStack {
            Group {
                if floats.isEmpty {
                    Text("There are no saved floats yet")
                        .font(.headline)
                        .offset(y: -60)
                } else {
                    List {
                        ForEach(floats) { item in
                            NavigationLink(value: item) {
                                makeLabel(with: item)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
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
            .task {
                floats = await CoreDataManager.instance.fetch()
            }
            .navigationDestination(for: FloatDB.self) { item in
                makeDestination(with: item)
            }
        }
    }
    
    @ViewBuilder func makeDestination(with item: FloatDB) -> some View {
        let floatQuery = PrintQuery(type: .float, cash: item.float.unwrap(), till: item.till ?? "Any Till", lead: item.lead ?? "Anonymous", date: item.date ?? Date.now, image: imageData.toImage())
        
        let cashoutQuery = PrintQuery(type: .cashout, cash: item.cashout.unwrap(), till: item.till ?? "Any Till", lead: item.lead ?? "Anonymous", date: item.date ?? Date.now, image: imageData.toImage())
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            PhoneSingleView(float: floatQuery, cashout: cashoutQuery)
        } else {
            PadDualView(float: floatQuery, cashout: cashoutQuery)
        }
    }
    
    @ViewBuilder func makeLabel(with item: FloatDB) -> some View {
        VStack(alignment: .leading) {
            Text((item.date ?? Date.now).regularText())
                .font(.headline)
            Text("Till: \(item.till ?? "Any Till")")
                .foregroundColor(.secondary)
            Text("Shift Lead: \(item.lead ?? "Anonymous")")
                .foregroundColor(.secondary)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.map { floats[$0] }
            .forEach(CoreDataManager.instance.container.viewContext.delete)
        CoreDataManager.instance.save()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


