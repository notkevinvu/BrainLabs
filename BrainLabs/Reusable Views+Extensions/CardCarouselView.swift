//
//  CardCarouselView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

struct GameModelMock: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    
}

struct CardCarouselView: View {
    var mockData: [GameModelMock] = [
        .init(title: "Aim trainer", subtitle: "Test your hand eye coordination and reaction."),
        .init(title: "Chimp test", subtitle: "Monkey see, monkey do."),
        .init(title: "Texting", subtitle: "How fast can you type up that story to your friend?"),
        .init(title: "Number memory", subtitle: "In this case, the longer the number, the better it is.")
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(mockData) { gameModel in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
                            .frame(width: 300, height: 100)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 30)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CardCarouselView()
}
