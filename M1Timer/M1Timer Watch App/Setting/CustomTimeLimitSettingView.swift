//
//  CustomTimeLimitSettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct CustomTimeLimitSettingView: View {
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
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
                timeLimit = TimeInterval(minute * 60 + second)
                if let index = path.firstIndex(of: .customTimeLimit),
                   let parentIndex = path.firstIndex(of: .timeLimit) {
                    path.remove(at: index)
                    path.remove(at: parentIndex)
                }
            } label: {
                Text(String(localized: "Set", defaultValue: "Set"))
            }
            .padding()
            .controlSize(.mini)
        }
        .navigationTitle(String(localized: "Time Limit", defaultValue: "Time Limit"))
    }
        
}

#Preview {
    @State var path = [Path.timeLimit]
    return CustomTimeLimitSettingView(path: $path)
}
