//
//  LargeCardCarouselView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/19/24.
//

import SwiftUI

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

struct LargeCardCarouselView: View {
    enum Constants {
        static let cardHeight: CGFloat = 225
    }
    
    struct CardModel {
        let title: String
        let subtitle: String?
        let image: Image
        let cardDetailSizeInfo: CardDetailSizeInformation
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
                            image: gameModel.placeholderImage,
                            cardDetailSizeInfo: cardDetailSizeInformation))
                    
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
    func titleSubtitleImageLargeCardView(cardModel: CardModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)).gradient
            )
            .frame(width: cardModel.cardDetailSizeInfo.cardWidth, height: cardModel.cardDetailSizeInfo.containerHeight)
            .overlay {
                VStack {
                    cardModel.image
                        .resizable()
                        .frame(
                            width: cardModel.cardDetailSizeInfo.imageDimension,
                            height: cardModel.cardDetailSizeInfo.imageDimension)
                    
                    Text(cardModel.title)
                        .font(.title.bold())
                        
                    Text(cardModel.subtitle ?? "")
                        .font(.subheadline.weight(.medium))
                }
                .padding(.horizontal, 30)
            }
        
        
    }
    
    private func getCardDetailSizeInformationFrom(_ geometryReader: GeometryProxy) -> CardDetailSizeInformation {
        let frameWidth = geometryReader.size.width
        let cardWidth = frameWidth * 0.95
        let cardHorizontalPadding = (frameWidth - cardWidth) / 2
        
        let imageDimension = Constants.cardHeight * 0.4
        
        return .init(
            cardWidth: cardWidth,
            cardHorizontalPadding: cardHorizontalPadding,
            containerHeight: geometryReader.size.height,
            imageDimension: imageDimension)
    }
}

#Preview {
    LargeCardCarouselView()
        .previewLayout(.sizeThatFits)
}
