//
//  RecommendationsProvider.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/22/24.
//

import Foundation

protocol RecommendationsProvider {
    func getFavorites() -> [GameModel]
    func getNewRecommendations() -> [GameModel]
}

#warning("Remove mock model and data, add specific colors to each game when creating actual models")
final class RecommendationsProviderImpl: RecommendationsProvider {
    func getFavorites() -> [GameModel] {
        let favorites: [GameModel] = [
            .init(title: "Aim trainer", subtitle: "Test your hand eye coordination and reaction."),
            .init(title: "Chimp test", subtitle: "Monkey see, monkey do."),
            .init(title: "Texting", subtitle: "How fast can you type up that story to your friend?"),
            .init(title: "Number memory", subtitle: "In this case, bigger is better.")
        ]
        
        return favorites
    }
    
    func getNewRecommendations() -> [GameModel] {
        let recommendations: [GameModel] = [
            .init(title: "Visual memory", subtitle: "Remember an increasingly bigger board of squares."),
            .init(title: "Verbal memory", subtitle: "How many words can you remember?"),
            .init(title: "Reaction time", subtitle: "Don't worry, going fast here is recommended."),
            .init(title: "Sequence memory", subtitle: "Remember an increasingly longer pattern of button presses."),
        ]
        
        return recommendations
    }
    
}

let mockRecommendationsModels: [GameModel] = [
    .init(title: "Aim trainer", subtitle: "Test your hand eye coordination and reaction."),
    .init(title: "Chimp test", subtitle: "Monkey see, monkey do."),
    .init(title: "Texting", subtitle: "How fast can you type up that story to your friend?"),
    .init(title: "Number memory", subtitle: "In this case, bigger is better.")
]
