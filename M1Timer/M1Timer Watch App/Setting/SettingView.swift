//
//  SettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

///  Back to Defaultの場合、pathとtimeIntervalがnilとなる
struct TimeSetting: Identifiable {
    var id = UUID()
    let path: Path?
    let timeInterval: TimeInterval?
}

struct SettingView: View {
    @Binding var path: [Path]
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    private var timeSettings: [TimeSetting] {
        [
            TimeSetting(path: .timeLimit, timeInterval: timeLimit),
            TimeSetting(path: .vibrationInterval, timeInterval: vibrationInterval),
            TimeSetting(path: nil, timeInterval: nil)
        ]
    }

    var body: some View {
        List {
            ForEach(timeSettings) { setting in
                VStack(alignment: .leading) {
                    if let currentPath = setting.path,
                       let timeInterval = setting.timeInterval {
                        TimeIntervalButton(
                            path: $path,
                            currentPath: currentPath,
                            timeInterval: timeInterval
                        )
                    } else {
                        Button {
                            timeLimit = 120
                            vibrationInterval = 60
                        } label: {
                            Text(String(localized: "Back to Default", defaultValue: "Back to Default"))
                        }
                    }
                    
                }
            }
        }
        .navigationTitle(String(localized: "Setting", defaultValue: "Setting"))
    }
}

private struct TimeIntervalButton: View {
    @Binding var path: [Path]
    let currentPath: Path
    let timeInterval: TimeInterval
    var body: some View {
        Text(currentPath.title)
        .font(.footnote)
        Button {
            path.append(currentPath)
        } label: {
            Text(displayTime(timeInterval))
        }
    }
    
    private func displayTime(_ setting: TimeInterval) -> String {
        var displayTime = ""
        displayTime += String(Int(timeInterval) / 60)
        displayTime += " " + String(localized: "min", defaultValue: "min") + " "
        if Int(timeInterval) % 60 != 0 {
            displayTime += String((Int(timeInterval) % 60))
            displayTime  += " " + String(localized: "sec", defaultValue: "sec") + " "
        }
        return displayTime
    }
}


#Preview {
    @State var path = [Path.setting]
    return SettingView(path: $path)
}
