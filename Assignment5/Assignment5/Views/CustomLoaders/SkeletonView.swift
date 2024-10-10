//
//  SkeletonView.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

struct SkeletonView: View {
    // MARK: - BODY

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.Surface.skeletonStart)
            .redacted(reason: .placeholder)
            .skeletonEffect(
                isLoading: .constant(true),
                gradient: Gradient(colors: [
                    Color.Surface.skeletonStart,
                    Color.Surface.skeletonEnd,
                    Color.Surface.skeletonStart,
                ])
            )
    }
}

// MARK: - PREVIEW

#Preview {
    SkeletonView()
}
