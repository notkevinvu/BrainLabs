//
//  LargeCardCarouselView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

struct LargeCardCarouselView: View {
    @Environment(\.colorScheme) var colorScheme
    var foregroundColor: Color {
//        colorScheme == .light ? .black : .white
        .white
    }
    
    let cardModels: [CardModel]
    
    struct CardModel: Identifiable {
        let id: UUID
        let title: String
        let subtitle: String?
        let image: Image
    }
    
    struct CardDetailSizeInformation {
        let cardWidth: CGFloat
        let cardHorizontalPadding: CGFloat
        let containerHeight: CGFloat
        let imageDimension: CGFloat
    }
    
    var body: some View {
        GeometryReader { geometry in
            let cardDetailSizeInformation = getCardDetailSizeInformationFrom(geometry)
            
            carouselScrollView(cardDetailSizeInformation: cardDetailSizeInformation)
        }
    }
    
    @ViewBuilder
    func carouselScrollView(cardDetailSizeInformation: CardDetailSizeInformation) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(mockData) { gameModel in
                    titleSubtitleImageLargeCardView(
                        cardModel: .init(
                            title: gameModel.title,
                            subtitle: gameModel.subtitle,
                            image: gameModel.placeholderImage),
                        cardDetailSizeInfo: cardDetailSizeInformation
                    )
                    
                } // for each
            } // lazy HStack
            .scrollTargetLayout()
        } // scroll view
        .scrollTargetBehavior(.viewAligned)
        // allows for parent padding while also not clipping overflow from padding
        .scrollClipDisabled()
        .safeAreaPadding(.horizontal, cardDetailSizeInformation.cardHorizontalPadding)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func titleSubtitleImageLargeCardView(cardModel: CardModel, cardDetailSizeInfo: CardDetailSizeInformation) -> some View {
        #warning("Update color to correspond to a specific game")
        RoundedRectangle(cornerRadius: 25)
            .fill(
                Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)).gradient
            )
            .frame(width: cardDetailSizeInfo.cardWidth, height: cardDetailSizeInfo.containerHeight)
            .overlay {
                VStack {
                    // TODO: Handle cases for dynamic text for XXL and onwards
                    // put a max size for the image?
                    cardModel.image
                        .resizable()
                        .foregroundStyle(foregroundColor)
                        .frame(
                            width: cardDetailSizeInfo.imageDimension,
                            height: cardDetailSizeInfo.imageDimension)
                    
                    Text(cardModel.title)
                        .font(.title.bold())
                        .foregroundStyle(foregroundColor)
                        
                    Text(cardModel.subtitle ?? "")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(foregroundColor)
                } // vstack
                .padding(.horizontal, 30)
            } // overlay
    }
    
    private func getCardDetailSizeInformationFrom(_ geometryReader: GeometryProxy) -> CardDetailSizeInformation {
        let frameWidth = geometryReader.size.width
        let cardWidth = frameWidth * 0.95
        let cardHorizontalPadding = (frameWidth - cardWidth) / 2
        
        // base image on card width since the height might be too variable for our tastes
        let imageDimension = cardWidth * 0.3
        
        return .init(
            cardWidth: cardWidth,
            cardHorizontalPadding: cardHorizontalPadding,
            containerHeight: geometryReader.size.height,
            imageDimension: imageDimension)
    }
}

#Preview(traits: .fixedLayout(width: 393, height: 225)) {
    LargeCardCarouselView()
}
