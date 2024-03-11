//
//  BrainLabsApp.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/15/24.
//

import SwiftUI

@main
struct BrainLabsApp: App {
    
    init() {
        DIContainer.shared.injectModules()
    }
    
    var body: some Scene {
        WindowGroup {
            CoreTabView()
        }
    }
}
