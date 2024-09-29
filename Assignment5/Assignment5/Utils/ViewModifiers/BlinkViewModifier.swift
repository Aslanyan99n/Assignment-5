//
//  BlinkViewModifier.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import SwiftUI

struct BlinkViewModifier: ViewModifier {
    // MARK: - Properties

    let duration: Double
    @State private var blinking: Bool = false

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                blinking.toggle()
            }
    }
}
