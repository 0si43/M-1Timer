//
//  TimeLimitSettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeLimitSettingView: View {
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    @State var selectedTimeLimit: Timelimit = .two
    @State var selectedVibrationInterval: TimeInterval = 60
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Text("Time limit")
                Spacer()
                Text("Interval")
                Spacer()
            }
            VStack {
                Picker("min", selection: $selectedTimeLimit) {
                    ForEach(Timelimit.allCases) {
                        Text($0.title)
                    }
                }
                .onChange(of: selectedTimeLimit) {
                    if let interval = selectedTimeLimit.interval {
                        vibrationInterval = interval
                    } else {
                        // …
                    }
                }
                Picker("", selection: $selectedVibrationInterval) {
                    ForEach(1..<61) {
                        Text(String($0))
                    }
                }
                .onChange(of: vibrationInterval) {
                    vibrationInterval = selectedVibrationInterval
                }
            }
            VStack {
                Picker("sec", selection: $selectedTimeLimit) {
                    ForEach(Timelimit.allCases) {
                        Text($0.title)
                    }
                }
                .onChange(of: selectedTimeLimit) {
                    if let interval = selectedTimeLimit.interval {
                        vibrationInterval = interval
                    } else {
                        // …
                    }
                }
                Picker("", selection: $selectedVibrationInterval) {
                    ForEach(1..<61) {
                        Text(String($0))
                    }
                }
                .onChange(of: vibrationInterval) {
                    vibrationInterval = selectedVibrationInterval
                }
            }
        }
        .onAppear {
            selectedTimeLimit = Timelimit(interval: timeLimit)
            selectedVibrationInterval = vibrationInterval
        }
    }
}

#Preview {
    TimeLimitSettingView()
}
