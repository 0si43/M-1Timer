//
//  Timelimit.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import Foundation

enum TimeLimit: CaseIterable, Identifiable {
    case two, three, four, five, other
    
    var id: Self { self }
    var title: String {
        switch self {
        case .two: "2 min"
        case .three: "3 min"
        case .four: "4 min"
        case .five: "5 min"
        case .other: "Other"
        }
    }
}
