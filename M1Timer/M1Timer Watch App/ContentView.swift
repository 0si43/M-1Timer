//
//  ContentView.swift
//  M1Timer Watch App
//
//  Created by Nakajima on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    Button {
                        // …
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
                        // …
                    } label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                    Text("Setting")
                    .font(.footnote)
                }
            }
//            .padding()
            .navigationTitle("M-1 Timer")
        }
    }
}

#Preview {
    ContentView()
}
