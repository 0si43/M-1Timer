//
//  TimeLimitSettingView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimeLimitSettingView: View {
    @Binding var path: [Path]
    var body: some View {
        List {
            ForEach(TimeLimit.allCases) { timeLimit in
                Button {
                    // ….
                } label: {
                    Text(timeLimit.title)
                }
            }
        }
    }
}

#Preview {
    @State var path = [Path.timeLimit]
    return TimeLimitSettingView(path: $path)
}
