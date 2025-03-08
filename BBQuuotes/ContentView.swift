//
//  ContentView.swift
//  BBQuuotes
//
//  Created by Arun  on 07/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Braking Bad", systemImage: "tortoise"){
                Text("Braking Bad View")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Better Call Saul", systemImage: "briefcase"){
                Text("Better Call Saul View")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
