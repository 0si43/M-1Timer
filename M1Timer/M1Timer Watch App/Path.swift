//
//  Path.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import Foundation

enum Path {
    case timer, setting
    case timeLimit, vibrationInterval
    
    var title: String {
        switch self {
        case .timer: ""
        case .setting: ""
        case .timeLimit: String(localized: "Time Limit", defaultValue: "Time Limit")
        case .vibrationInterval: String(localized: "Vibration Interval", defaultValue: "Vibration Interval")
        }
    }

}

