//
//  SkeletonEffect.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

struct SkeletonEffect: Animatable, ViewModifier {
    // MARK: - PROPERTIES

    @State private var isAnimating: Bool = false
    @Binding var isLoading: Bool
    private let animation: Animation
    private let gradient: Gradient
    private let min = 0.5
    private let max = 1.0
    
    private var startPoint: UnitPoint {
        isAnimating ? UnitPoint(x: 1, y: 1) : UnitPoint(x: min, y: min)
    }

    private var endPoint: UnitPoint {
        isAnimating ? UnitPoint(x: max, y: max) : UnitPoint(x: 0, y: 0)
    }

    public static let defaultGradient: Gradient = .init(
        colors: [
            Color.Surface.skeletonStart,
            Color.Surface.skeletonEnd,
            Color.Surface.skeletonStart,
        ]
    )

    public static let defaultAnimation = Animation.linear(duration: 2).repeatForever(autoreverses: false)

    // MARK: - INIT

    init(
        isLoading: Binding<Bool>,
        gradient: Gradient = Self.defaultGradient,
        animation: Animation = Self.defaultAnimation
    ) {
        self._isLoading = isLoading
        self.gradient = gradient
        self.animation = animation
    }

    // MARK: - BODY

    func body(content: Content) -> some View {
        if isLoading {
            content
                .overlay {
                    skeletonView
                        .mask(content)
                }
        } else {
            content
        }
    }
    
    // MARK: - SKELETON VIEW

    var skeletonView: some View {
        LinearGradient(gradient: self.gradient, startPoint: startPoint, endPoint: endPoint)
            .animation(animation, value: isAnimating)
            .scaleEffect(3)
            .onAppear {
                guard isLoading else { return }
                isAnimating = true
            }
            .onChange(of: isLoading) { _ in
                isAnimating.toggle()
            }
    }
}
