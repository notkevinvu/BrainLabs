//
//  CoreTabView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/15/24.
//

import SwiftUI

struct CoreTabView: View {
    var body: some View {
        TabView {
            HomeView(homeViewModel: DIContainer.shared.resolve(HomeViewModel.self))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AllGamesView()
                .tabItem {
                    Label("Games", systemImage: "square.grid.3x3.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    CoreTabView()
}
