//
//  View+Ext.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import SwiftUI

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

extension View {
    @ViewBuilder func isLoading(_ flag: Bool) -> some View {
        self.overlay {
            if flag {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                    .controlSize(.large)
            }
        }
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


extension View {
    func blinking(duration: Double = 1) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    func skeletonEffect(
        isLoading: Binding<Bool>,
        gradient: Gradient = SkeletonEffect.defaultGradient,
        animation: Animation = SkeletonEffect.defaultAnimation
    ) -> some View {
        modifier(
            SkeletonEffect(
                isLoading: isLoading,
                gradient: gradient,
                animation: animation
            )
        )
    }
}
