//
//  HomeView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

struct HomeView: View {
    @State var homeViewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text("Brain Lab")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                welcomeText
                
                ForEach(homeViewModel.homeViewSections) { section in
                    carouselSection(title: section.title, gameModels: section.gameModels)
                }
            } // vstack
            .padding(20)
        } // scrollview
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    var welcomeText: some View {
        ZStack(alignment: .leading, content: {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.gray.gradient)
                .brightness(0.4)
                .defaultShadow()
            
            Text(homeViewModel.welcomeText)
                .font(.headline)
                .foregroundStyle(.black)
                .padding(15)
        })
    }
    
    @ViewBuilder
    func carouselSection(title: String, gameModels: [GameModel]) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            LargeCardCarouselView(
                cardModels: gameModels.map { $0.toCarouselViewCardModel() }
            )
                .frame(minHeight: 225)
                .defaultShadow()
        }
    }
}

#Preview {
    HomeView(homeViewModel: DIContainer.shared.resolve(HomeViewModel.self))
}
