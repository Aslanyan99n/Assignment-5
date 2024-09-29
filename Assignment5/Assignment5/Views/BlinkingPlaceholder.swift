//
//  BlinkingPlaceholder.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import SwiftUI

struct BlinkingPlaceholder: View {
    // MARK: - Body

    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.7))
            .blinking(duration: 0.8)
    }
}

// MARK: - Preview

#Preview {
    BlinkingPlaceholder()
}
