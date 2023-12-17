//
//  SettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeSetting: Identifiable {
    var id = UUID()
    let name: String
    let timeInterval: TimeInterval
}

struct SettingView: View {
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    private var timeSettings: [TimeSetting] {
        [
            TimeSetting(name: "Time Limit", timeInterval: timeLimit),
            TimeSetting(name: "Vibration Interval", timeInterval: vibrationInterval)
        ]
    }

    var body: some View {
        List {
            ForEach(timeSettings) { setting in
                VStack(alignment: .leading) {
                    Text(setting.name)
                    .font(.footnote)
                    Button {
                        // …
                    } label: {
                        Text(
                            String(Int(setting.timeInterval) / 60)
                            + " min "
                            + String((Int(setting.timeInterval) % 60))
                            + " sec"
                        )
                    }
                }
            }
        }
        .navigationTitle("Setting")
    }
}

#Preview {
    SettingView()
}
