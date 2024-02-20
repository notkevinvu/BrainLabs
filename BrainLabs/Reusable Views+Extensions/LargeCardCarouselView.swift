//
//  LargeCardCarouselView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

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
    .init(title: "Number memory", subtitle: "In this case, the longer the number, the better it is.")
]

struct LargeCardCarouselView: View {
    enum Constants {
        static let cardHeight: CGFloat = 225
    }
    
    struct CardModel {
        let title: String
        let subtitle: String?
        let image: Image
        let cardWidth: CGFloat
    }
    
    var body: some View {
        GeometryReader { geometry in
            let frameSize = geometry.size
            let cardWidth = frameSize.width * 0.85
            let cardHorizontalPadding = (frameSize.width - cardWidth) / 2
            
            carouselScrollView(
                cardWidth: cardWidth,
                cardHorizontalPadding: cardHorizontalPadding
            )
        }
    }
    
    @ViewBuilder
    func carouselScrollView(cardWidth: CGFloat, cardHorizontalPadding: CGFloat) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(mockData) { gameModel in
                    titleSubtitleImageLargeCardView(
                        cardModel: .init(
                            title: gameModel.title,
                            subtitle: gameModel.subtitle,
                            image: gameModel.placeholderImage,
                            cardWidth: cardWidth
                        )
                    ) // card view
                } // for each
            } // lazy HStack
            .scrollTargetLayout()
        } // scroll view
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, cardHorizontalPadding)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func titleSubtitleImageLargeCardView(cardModel: CardModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
                .frame(width: cardModel.cardWidth, height: Constants.cardHeight)
        } // zstack
    }
}

#Preview {
    LargeCardCarouselView()
        .previewLayout(.sizeThatFits)
}
