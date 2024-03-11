//
//  SafeAreaBottomPadding.swift
//  BrainLabs
//
//  Created by Kevin Vu on 3/11/24.
//

import SwiftUI

struct SafeAreaBottomPadding: ViewModifier {
    func body(content: Content) -> some View {
        if UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 {
            content.padding(.bottom)
        } else {
            content
        }
    }
}

extension View {
    /// Adds safe area bottom padding only when the device being used is a "small" type (i.e. one with
    /// TouchID).
    ///
    /// Reference: https://www.hackingwithswift.com/forums/swiftui/adding-bottom-spacing-on-non-face-id-phones/12181
    func safeAreaBottomPadding() -> some View {
        modifier(SafeAreaBottomPadding())
    }
}
