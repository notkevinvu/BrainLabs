//
//  HomeViewModel.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/22/24.
//

import Foundation
// TODO: Remove swiftui once we finish with the model mocks
import SwiftUI

@Observable
final class HomeViewModel {
    let recommendationsProvider: RecommendationsProvider
    
    var welcomeText: String = "Welcome back to the lab! Revisit your favorites, explore new games, or check out your highlights and stats!"
    var homeViewSections: [HomeSectionModel] = []
    var viewState: ViewState = .initial
    
    enum ViewState {
        /*
         We mainly have 2 sections:
         1) Recents/favorites - Top 3 most played/recently played games; can be empty as new users might not have played anything yet
         2) Try something new - criteria for this is least played games, but may change later if we have a new game that we want to push as a recommendation
         
         The second section (new games) will never be empty as we will always have 3 games that fit the criteria. If all games have equal play count, we will simply randomize it to games that are not present in the favorites section.
         
         However, we might have a scenario where a new user opens the home page and thus has no favorites since they are new
         */
        case initial // show shimmering effect here if possible
        case loading
        case success
        case emptyFavorites
        case failure
    }
    
    struct HomeSectionModel: Identifiable {
        let id = UUID()
        let title: String
        // do we want to store the card items in here or in the top level view model?
        let gameModels: [GameModel]
    }
    
    init(recommendationsProvider: RecommendationsProvider = RecommendationsProviderImpl()) {
        self.recommendationsProvider = recommendationsProvider
        buildSections()
    }
    
    private func buildSections() {
        viewState = .loading
        
        let favoriteGames = recommendationsProvider.getFavorites()
        let newRecommendations = recommendationsProvider.getNewRecommendations()
        
        homeViewSections.append(.init(title: "Favorites", gameModels: favoriteGames))
        homeViewSections.append(.init(title: "Try something new", gameModels: newRecommendations))
    }
}

#warning("Remove mock model and data, add specific colors to each game when creating actual models")
struct GameModelMock: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    let placeholderImage = Image(systemName: "brain.filled.head.profile")
}

var mockData: [GameModelMock] = [
    .init(title: "Aim trainer", subtitle: "Test your hand eye coordination and reaction."),
    .init(title: "Chimp test", subtitle: "Monkey see, monkey do."),
    .init(title: "Texting", subtitle: "How fast can you type up that story to your friend?"),
    .init(title: "Number memory", subtitle: "In this case, bigger is better.")
]
