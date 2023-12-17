//
//  TimerView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimerView: View {
    @State private var startAnimation = false
    @State private var passMinutes: Int = 0
    var body: some View {
        ZStack {
            VStack {
                Text(String(passMinutes))
                    .font(.system(size: 80))
                Text("min")
                    .font(.caption)
                    .bold()
            }
            .opacity(startAnimation ? 0.5 : 1)
            .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                       value: startAnimation)
            Circle()
                .stroke(.cyan, style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [1, 13]))
                .blur(radius: 1)
                .rotationEffect(.degrees(startAnimation ? 360 : 0))
                .animation(.linear(duration: 30).repeatForever(autoreverses: false),
                           value: startAnimation)
        }
        .onAppear {
            startAnimation = true
        }
        
    }
}

#Preview {
    TimerView()
}
