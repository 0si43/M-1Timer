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
        case .timeLimit: "Time Limit"
        case .vibrationInterval: "Vibration Interval"
        }
    }

}

