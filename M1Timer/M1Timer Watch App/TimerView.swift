//
//  TimerView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimerView: View {
    @State var startAnimation = false
    @State var passMinutes: Int = 0
    @State var totalTime: TimeInterval = 120
    @State var timer: Timer?
    @State var interval: TimeInterval = 60
    var body: some View {
        ZStack {
            VStack {
                Text(String(passMinutes))
                    .font(.system(size: 80))
                    .opacity(startAnimation ? 0.5 : 1)
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                               value: startAnimation)
                Text("min")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .bold()
            }
            Circle()
                .stroke(.cyan, style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [1, 13]))
                .blur(radius: 1)
                .rotationEffect(.degrees(startAnimation ? 360 : 0))
                .animation(.linear(duration: 30).repeatForever(autoreverses: false),
                           value: startAnimation)
        }
        .onAppear {
            startAnimation = true
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                passMinutes += 1
            }
        }
        .navigationTitle("\(Int(totalTime / 60)) min")
    }
}

#Preview {
    TimerView()
}
