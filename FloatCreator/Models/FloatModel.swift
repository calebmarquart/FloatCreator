//
//  FloatModel.swift
//  FloatCreator (iOS)
//
//  Created by Caleb Marquart on 2023-01-13.
//

import Foundation

enum FloatType {
    case float
    case cashout
    
    func string() -> String {
        switch self {
        case .float:
            return "Float"
        case .cashout:
            return "Cashout"
        }
    }
}
