//
//  ContentView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    @State var path: [Path] = []
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @AppStorage("VibrationInterval") var vibrationInterval: TimeInterval = 60
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                VStack {
                    Button {
                        path.append(.timer)
                    } label: {
                        Image(systemName: "play")
                            .imageScale(.large)
                    }
                    .tint(.orange)
                    Text("Start")
                    .font(.footnote)
                }
                VStack {
                    Button {
                        path.append(.setting)
                    } label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                    Text("Setting")
                    .font(.footnote)
                }
            }
            .navigationTitle("M-1 Timer")
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .timer:
                    TimerView(path: $path)
                case .setting:
                    SettingView(path: $path)
                case .timeLimit:
                    TimeLimitSettingView(path: $path)
                case .vibrationInterval:
                    TimeIntervalSettingView(appStorageValue: $vibrationInterval, path: $path)
                case .customTimeLimit:
                    TimeIntervalSettingView(appStorageValue: $timeLimit, path: $path)
                }
            
            }
        }
    }
}

#Preview {
    ContentView()
}
