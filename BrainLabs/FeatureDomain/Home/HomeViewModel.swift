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
    var welcomeText: String = "Welcome back to the lab! Revisit your favorites, explore new games, or check out your highlights and stats!"
    var homeViewSections: [HomeSectionModel] = []
    
    enum ViewState {
        case initial
        case loading
        case success
        case empty
        case failure
    }
    
    struct HomeSectionModel: Identifiable {
        let id = UUID()
        let title: String
    }
    
    init() {
        buildSections()
    }
    
    private func buildSections() {
        homeViewSections.append(.init(title: "Recents"))
        homeViewSections.append(.init(title: "Try something new"))
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
