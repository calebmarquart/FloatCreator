//
//  ListViewModel.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-21.
//

import SwiftUI

class ListViewModel: ObservableObject {
    @AppStorage("image_data") private var imageData = Data()
    
    @Published var floats = [FloatDB]()
    
    func fetchFloats() async {
        let floats = await CoreDataManager.instance.fetch()
        DispatchQueue.main.async {
            self.floats = floats
        }
    }
    
    @ViewBuilder func makeNavigationDestination(with item: FloatDB) -> some View {
        let (float, cashout) = makeFloatCashout(from: item)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            PhoneSingleView(float: float, cashout: cashout)
        } else {
            PadDualView(float: float, cashout: cashout)
        }
    }
    
    @ViewBuilder func makeNavigationLabel(with item: FloatDB) -> some View {
        VStack(alignment: .leading) {
            Text((item.date ?? Date.now).regularText())
                .font(.headline)
            Text("Till: \(item.till ?? "Any Till")")
                .foregroundColor(.secondary)
            Text("Shift Lead: \(item.lead ?? "Anonymous")")
                .foregroundColor(.secondary)
        }
    }
        
    func delete(at offsets: IndexSet) {
        offsets.map { floats[$0] }
            .forEach(CoreDataManager.instance.container.viewContext.delete)
        CoreDataManager.instance.save()
    }
    
    private func makeFloatCashout(from item: FloatDB) -> (PrintQuery, PrintQuery) {
        let till: String = item.till ?? "Any Till"
        let lead: String = item.lead ?? "Anonymous"
        let date: Date = item.date ?? Date.now
        let image = imageData.toImage()
        
        let float = PrintQuery(type: .float, cash: item.float.unwrap(), till: till, lead: lead, date: date, image: image)
        let cashout = PrintQuery(type: .cashout, cash: item.cashout.unwrap(), till: till, lead: lead, date: date, image: image)
        
        return (float, cashout)
    }
}
