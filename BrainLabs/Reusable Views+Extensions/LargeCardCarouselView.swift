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
        static let cardRelativeWidth: CGFloat = 0.95
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
                ForEach(cardModels) { gameModel in
                    largeCardView(
                        cardModel: .init(
                            id: gameModel.id,
                            title: gameModel.title,
                            subtitle: gameModel.subtitle,
                            image: gameModel.image),
                        cardDetailSizeInfo: cardDetailSizeInformation
                    )
                    
                } // for each
            } // lazy HStack
            .scrollTargetLayout()
        } // scroll view
        .scrollTargetBehavior(.viewAligned)
        // not sure what the difference between this and .safeAreaPadding is
        .contentMargins(.horizontal, cardDetailSizeInformation.cardHorizontalPadding, for: .scrollContent)
        // allows for parent padding while also not clipping overflow from padding
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func largeCardView(cardModel: CardModel, cardDetailSizeInfo: CardDetailSizeInformation) -> some View {
        #warning("Update color to correspond to a specific game")
        RoundedRectangle(cornerRadius: 25)
            .fill(
                Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)).gradient
            )
            .containerRelativeFrame(.horizontal)
            .overlay {
                titleSubtitleImageOverlayView(cardModel: cardModel, cardDetailSizeInfo: cardDetailSizeInfo)
            } // overlay
    }
    
    @ViewBuilder
    func titleSubtitleImageOverlayView(cardModel: CardModel, cardDetailSizeInfo: CardDetailSizeInformation) -> some View {
        VStack {
            cardModel.image
                .resizable()
                .foregroundStyle(foregroundColor)
                .frame(
                    idealWidth: cardDetailSizeInfo.imageDimension,
                    maxWidth: cardDetailSizeInfo.imageDimension,
                    idealHeight: cardDetailSizeInfo.imageDimension,
                    maxHeight: cardDetailSizeInfo.imageDimension
                )
            
            Text(cardModel.title)
                .font(.title.bold())
                .foregroundStyle(foregroundColor)
                
            Text(cardModel.subtitle ?? "")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(foregroundColor)
        } // vstack
        .padding(.horizontal, 30)
    }
    
    private func getCardDetailSizeInformationFrom(_ geometryReader: GeometryProxy) -> CardDetailSizeInformation {
        let frameWidth = geometryReader.size.width
        let cardWidth = frameWidth * CardDetailSizeInformation.cardRelativeWidth
        let cardHorizontalPadding = (frameWidth - cardWidth) / 2
        
        // base image on card width since the height might be too variable for our tastes
        let imageDimension = cardWidth * 0.3
        
        return .init(
            cardHorizontalPadding: cardHorizontalPadding,
            containerHeight: geometryReader.size.height,
            imageDimension: imageDimension)
    }
}

#Preview(traits: .fixedLayout(width: 393, height: 225)) {
    LargeCardCarouselView(cardModels: mockRecommendationsModels.map { $0.toCarouselViewCardModel() } )
}
