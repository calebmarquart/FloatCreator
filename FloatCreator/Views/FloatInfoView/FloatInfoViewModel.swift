//
//  FloatInfoViewModel.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-21.
//

import SwiftUI

class FloatInfoViewModel: ObservableObject {
    
    @AppStorage("image_data") private var imageData = Data()
    
    @Published var till = ""
    @Published var lead = ""
    
    @Published var float: PrintQuery = previewQuery
    @Published var cashout: PrintQuery = previewQuery
    
    @Published var showingDetail = false
    
    func createFloat(with configuration: Cash) {
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
}
