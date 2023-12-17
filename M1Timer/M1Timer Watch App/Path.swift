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
    case customTimeLimit
    
    var title: String {
        switch self {
        case .timer: ""
        case .setting: ""
        case .timeLimit: String(localized: "Time Limit", defaultValue: "Time Limit")
        case .vibrationInterval: String(localized: "Vibration Interval", defaultValue: "Vibration Interval")
        case .customTimeLimit: String(localized: "Time Limit", defaultValue: "Time Limit")
        }
    }

}

