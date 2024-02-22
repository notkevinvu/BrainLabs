//
//  DefaultShadowModifier.swift
//  BrainLabs
//
//  Created by Kevin Vu on 2/22/24.
//

import SwiftUI

fileprivate struct DefaultShadowModifier: ViewModifier {
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(radius: radius, x: x, y: y)
    }
}

extension View {
    func defaultShadow() -> some View {
        modifier(DefaultShadowModifier(radius: 5, x: 2.5, y: 5))
    }
}
