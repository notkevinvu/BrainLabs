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
        ZStack {
            VStack {
                TabView {
                    HomeView(homeViewModel: DIContainer.shared.resolve(HomeViewModel.self))
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    AllGamesView()
                        .tabItem {
                            Label("Games", systemImage: "square.grid.3x3.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
            }
            
            VStack {
                Spacer()
                CustomTabView(selectedTab: $selectedTab)
            }
        }
    }
}

struct CustomTabView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        selectedTab.symbolName + ".fill"
    }
    
    private var bottomPadding: CGFloat {
        verticalSizeClass == .compact ? 5 : 0
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    let isSelectedTab = selectedTab == tab
                    let foregroundColor: Color = isSelectedTab ? .red : .gray
                    
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
            .safeAreaPadding(.bottom, bottomPadding)
        }
    }
}

#Preview {
    CoreTabView()
}
