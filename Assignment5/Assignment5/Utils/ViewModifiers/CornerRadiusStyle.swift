//
//  CornerRadiusStyle.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import SwiftUI

struct CornerRadiusStyle: ViewModifier {
    // MARK: - Properties
    
    var radius: CGFloat
    var corners: UIRectCorner
    
    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
