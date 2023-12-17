//
//  Timelimit.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import Foundation

enum Timelimit: CaseIterable, Identifiable {
    case two, three, four, five, other
    
    init(interval: TimeInterval) {
        switch interval {
        case 120: self = .two
        case 180: self = .three
        case 240: self = .four
        case 300: self = .five
        default: self = .other
        }
    }
    
    var id: Self { self }
    var title: String {
        switch self {
        case .two: "2"
        case .three: "3"
        case .four: "4"
        case .five: "5"
        case .other: "Other"
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
