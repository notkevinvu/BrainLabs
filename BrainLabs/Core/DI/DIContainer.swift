//
//  DIContainer.swift
//  BrainLabs
//
//  Created by Kevin Vu on 3/11/24.
//

import Foundation
import Swinject

/// A singleton class responsible for injecting dependencies within the app.
final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    private var container = Container()
    
    @MainActor
    func injectModules() {
        injectServices()
        injectProviders()
        injectViewModels()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        // Crashing here is good as it means we have not correctly
        // injected/registered the specific dependency and can then fix.
        container.resolve(T.self)!
    }
}

extension DIContainer {
    // MARK: -- Injecting managers/services
    
    private func injectServices() {
        // no managers at the moment
    }
    
    // MARK: -- Injecting providers
    
    private func injectProviders() {
        container.register(RecommendationsProvider.self) { resolver in
            return RecommendationsProviderImpl()
        }
        .inObjectScope(.container)
    }
    
    // MARK: -- Injecting view models
    
    private func injectViewModels() {
        container.register(HomeViewModel.self) { resolver in
            return HomeViewModel(
                recommendationsProvider: resolver.resolve(RecommendationsProvider.self)!
            )
        }
        .inObjectScope(.container)
    }
}
