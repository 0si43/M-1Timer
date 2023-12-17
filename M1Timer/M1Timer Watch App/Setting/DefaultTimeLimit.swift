//
//  DefaultTimeLimit.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import Foundation

enum DefaultTimeLimit: CaseIterable, Identifiable {
    case two, three, four, five, other
    
    var id: Self { self }
    var title: String {
        switch self {
        case .two: "2 " + String(localized: "min", defaultValue: "min")
        case .three: "3 " + String(localized: "min", defaultValue: "min")
        case .four: "4 " + String(localized: "min", defaultValue: "min")
        case .five: "5 " + String(localized: "min", defaultValue: "min")
        case .other: String(localized: "Other", defaultValue: "Other")
        }
    }
    
    var interval: TimeInterval? {
        switch self {
        case .two: 120
        case .three: 180
        case .four: 240
        case .five: 300
        case .other: nil
        }
    }
}
