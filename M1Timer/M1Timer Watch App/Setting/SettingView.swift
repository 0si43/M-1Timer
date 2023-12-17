//
//  SettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeSetting: Identifiable {
    var id = UUID()
    let path: Path
    let timeInterval: TimeInterval
}

struct SettingView: View {
    @Binding var path: [Path]
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    private var timeSettings: [TimeSetting] {
        [
            TimeSetting(path: .timeLimit, timeInterval: timeLimit),
            TimeSetting(path: .vibrationInterval, timeInterval: vibrationInterval)
        ]
    }

    var body: some View {
        List {
            ForEach(timeSettings) { setting in
                VStack(alignment: .leading) {
                    Text(setting.path.title)
                    .font(.footnote)
                    Button {
                        path.append(setting.path)
                    } label: {
                        Text(displayTime(setting))
                    }
                }
            }
        }
        .navigationTitle(String(localized: "Setting", defaultValue: "Setting"))
    }
    
    private func displayTime(_ setting: TimeSetting) -> String {
        var displayTime = ""
        displayTime += String(Int(setting.timeInterval) / 60)
        displayTime += " " + String(localized: "min", defaultValue: "min") + " "
        if Int(setting.timeInterval) % 60 != 0 {
            displayTime += String((Int(setting.timeInterval) % 60))
            displayTime  += " " + String(localized: "sec", defaultValue: "sec") + " "
        }
        return displayTime
    }
}

#Preview {
    @State var path = [Path.setting]
    return SettingView(path: $path)
}
