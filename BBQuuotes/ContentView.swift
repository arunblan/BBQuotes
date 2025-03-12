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
            Tab(Constants.bbName, systemImage: "tortoise"){
                FetchView(show: Constants.bbName)
            }
            Tab(Constants.bcName, systemImage: "briefcase"){
                FetchView(show: Constants.bcName)
            }
            
            Tab(Constants.ecName, systemImage: "car"){
                FetchView(show: Constants.ecName)
//                    .toolbarBackgroundVisibility(.visible, for: .tabBar) move to quote View for showing in all views
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
