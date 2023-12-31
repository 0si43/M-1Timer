//
//  TimerView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/17.
//

import SwiftUI

struct TimerView: View {
    @Binding var path: [Path]
    var timeLimit: TimeInterval
    var vibrationInterval: TimeInterval
    @StateObject var extendedRuntimeSession = ExtendedRuntimeSession()
    @State var startAnimation = false
    @State var passSeconds: TimeInterval = 0
    @State var timer: Timer?
    
    var body: some View {
        ZStack {
            VStack {
                Text(String(Int(passSeconds / 60)))
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
            start()
        }
        .onDisappear {
            end()
        }
        .navigationTitle("\(Int(timeLimit / 60)) " + String(localized: "min", defaultValue: "min"))
    }
    
    private func start() {
        extendedRuntimeSession.sessionEndCompletion = end
        extendedRuntimeSession.startSession()
        startAnimation = true
        timer = Timer.scheduledTimer(withTimeInterval: vibrationInterval, repeats: true) { timer in
            WKInterfaceDevice.current().play(.directionUp)
            passSeconds += vibrationInterval
            if timeLimit <= passSeconds {
                end()
            }
        }
        WKInterfaceDevice.current().play(.start)
    }
    
    private func end() {
        extendedRuntimeSession.endSession()
        startAnimation = false
        timer?.invalidate()
        timer = nil
        WKInterfaceDevice.current().play(.stop)
        if let index = path.firstIndex(of: .timer) {
            path.remove(at: index)
        }
    }
}

#Preview {
    @State var path = [Path.timer]
    return TimerView(path: $path, timeLimit: 120, vibrationInterval: 60)
}
