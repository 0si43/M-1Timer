//
//  SettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("Timelimit") var timelimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    @State var selectedTimelimit: Timelimit = .two
    @State var selectedVibrationInterval: TimeInterval = 60
    
    var body: some View {
        VStack {
            HStack() {
                Text("Time\nlimit")
                Picker("", selection: $selectedTimelimit) {
                    ForEach(Timelimit.allCases) {
                        Text($0.title)
                    }
                }
                .onChange(of: selectedTimelimit) {
                    if let interval = selectedTimelimit.interval {
                        vibrationInterval = interval
                    } else {
                        // …
                    }
                }
                Text("min")
            }
            HStack() {
                Text("Interval")
                Picker("", selection: $selectedVibrationInterval) {
                    ForEach(1..<61) {
                        Text(String($0))
                    }
                }
                .onChange(of: vibrationInterval) {
                    vibrationInterval = selectedVibrationInterval
                }
                Text("sec")
            }
        }
        .onAppear {
            selectedTimelimit = Timelimit(interval: timelimit)
            selectedVibrationInterval = vibrationInterval
        }
    }
}

#Preview {
    SettingView()
}
