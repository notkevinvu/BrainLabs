//
//  HomeView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text("Brain Lab")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // TODO: Make this text copy a card?
                Text("Welcome back! See your recent games, try something new, or quickly see your highlights!")
                    .font(.callout)
                
                carouselSection(title: "Recents")
                carouselSection(title: "Try something new")
            } // vstack
            .padding(20)
        } // scrollview
    }
    
    @ViewBuilder
    func carouselSection(title: String) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            LargeCardCarouselView()
                .frame(minHeight: 225)
        }
    }
}

#Preview {
    HomeView()
}
