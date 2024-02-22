//
//  GameModel.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/22/24.
//

import SwiftUI

struct GameModel: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image = Image(systemName: "brain.filled.head.profile")
}

extension GameModel {
    func toCarouselViewCardModel() -> LargeCardCarouselView.CardModel {
        return .init(id: self.id, title: self.title, subtitle: self.subtitle, image: self.image)
    }
}
