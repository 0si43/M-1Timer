//
//  TimeLimitSettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeLimitSettingView: View {
    @AppStorage("TimeLimit") var timeLimit: TimeInterval = 120
    @Binding var path: [Path]
    var body: some View {
        List {
            ForEach(DefaultTimeLimit.allCases) { defaultTimeLimit in
                Button {
                    if let interval = defaultTimeLimit.interval {
                        timeLimit = interval
                        guard !path.isEmpty else { return }
                        path.removeLast()
                    } else {
                        // …
                    }
                } label: {
                    Text(defaultTimeLimit.title)
                }
            }
        }
    }
}

#Preview {
    @State var path = [Path.timeLimit]
    return TimeLimitSettingView(path: $path)
}
