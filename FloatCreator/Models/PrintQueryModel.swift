//
//  PrintQueryModel.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-13.
//

import SwiftUI

struct PrintQuery: Identifiable {
    let id = UUID()
    let type: FloatType
    let cash: Cash
    let till: String
    let lead: String
    let date: Date
    let image: UIImage?
}

let previewQuery = PrintQuery(type: .float, cash: emptyCash, till: "", lead: "", date: Date.now, image: nil)
