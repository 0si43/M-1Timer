//
//  ContentView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    @State var path: [Path] = []
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
                    // FIXME: -
                    TimeLimitSettingView(path: $path)
                case .customTimeLimit:
                    CustomTimeLimitSettingView(path: $path)
                }
            
            }
        }
    }
}

#Preview {
    ContentView()
}
