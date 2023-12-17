//
//  ContentView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    @State private var showTimerView = false
    @State private var showSettingView = false
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    Button {
                        showTimerView = true
                    } label: {
                        Image(systemName: "play")
                            .imageScale(.large)
                    }
                    .tint(.orange)
                    .navigationDestination(isPresented: $showTimerView, destination: {
                        TimerView()
                    })
                    Text("Start")
                    .font(.footnote)
                }
                VStack {
                    Button {
                        showSettingView = true
                    } label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                    .navigationDestination(isPresented: $showSettingView, destination: {
                        SettingView()
                    })
                    Text("Setting")
                    .font(.footnote)
                }
            }
            .navigationTitle("M-1 Timer")
        }
    }
}

#Preview {
    ContentView()
}
