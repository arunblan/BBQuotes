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
                QuoteView(show: "Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Better Call Saul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
