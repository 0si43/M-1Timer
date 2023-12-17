//
//  TimeIntervalSettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeIntervalSettingView: View {
    @Binding var appStorageValue: TimeInterval
    @Binding var path: [Path]
    @State var minute: Int = 0
    @State var second: Int = 0
    var body: some View {
        VStack {
            HStack {
                Picker(String(localized: "minutes", defaultValue: "minutes"), selection: $minute) {
                    ForEach(0..<61) {
                        Text(String($0))
                    }
                }
                .font(.title2)
                .padding(.horizontal)
                Picker(String(localized: "seconds", defaultValue: "seconds"), selection: $second) {
                    ForEach(0..<60) {
                        Text(String($0))
                    }
                }
                .font(.title2)
                .padding(.horizontal)
            }
            Button {
                update()
            } label: {
                Text(String(localized: "Set", defaultValue: "Set"))
            }
            .padding()
            .controlSize(.mini)
        }
        .navigationTitle(path.last?.title ?? "")
    }
     
    private func update() {
        appStorageValue = TimeInterval(minute * 60 + second)
        guard let currentPath = path.last else { return }
        if let index = path.firstIndex(of: currentPath) {
            path.remove(at: index)
        }
        if case .customTimeLimit = currentPath {
            if let parentIndex = path.firstIndex(of: .timeLimit) {
                path.remove(at: parentIndex)
            }
        }
    }
}

#Preview {
    @State var timeLimit: TimeInterval = 120
    @State var path = [Path.timeLimit]
    return TimeIntervalSettingView(appStorageValue: $timeLimit, path: $path)
}
