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
    @State var path = [Path.setting]
    return SettingView(path: $path)
}
