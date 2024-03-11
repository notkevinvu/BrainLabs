//
//  CoreTabView.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/15/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case games
    case profile
    
    var symbolName: String {
        switch self {
            case .home:
                "house"
            case .games:
                "square.grid.3x3"
            case .profile:
                "person"
        }
    }
}

struct CoreTabView: View {
    @State private var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        defaultTabView
            .overlay(alignment: .bottom) {
                CustomTabView(selectedTab: $selectedTab)
            }
    }
    
    @ViewBuilder
    var defaultTabView: some View {
        TabView(selection: $selectedTab) {
            HomeView(homeViewModel: DIContainer.shared.resolve(HomeViewModel.self))
                .tag(Tab.home)
            
            AllGamesView()
                .tag(Tab.games)
            
            ProfileView()
                .tag(Tab.profile)
        }
    }
}

/// Custom floating tab view with scale effect animations.
///
/// References:
/// * https://www.youtube.com/watch?v=vzQDKYIKEb8
/// * https://www.youtube.com/watch?v=Yg3cmpKNieU
fileprivate struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        selectedTab.symbolName + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    let isSelectedTab = selectedTab == tab
                    let foregroundColor: Color = isSelectedTab ? .blue: .gray
                    
                    Spacer()
                    
                    Image(systemName: isSelectedTab ? fillImage : tab.symbolName)
                        .font(.system(size: 22))
                        .scaleEffect(isSelectedTab ? 1.25 : 1.0)
                    .foregroundStyle(foregroundColor)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            .safeAreaBottomPadding()
        }
    }
}

#Preview {
    CoreTabView()
}
