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
        
        /*
         TODO: Add logic to see if favorite games array is empty
         
         If so, we'll need some extra logic to update viewState to the
         `.emptyFavorites` case and handle view accordingly.
         */
        let favoriteGames = recommendationsProvider.getFavorites()
        let newRecommendations = recommendationsProvider.getNewRecommendations()
        
        homeViewSections.append(.init(title: "Favorites", gameModels: favoriteGames))
        homeViewSections.append(.init(title: "Try something new", gameModels: newRecommendations))
        
        viewState = .success
    }
}

