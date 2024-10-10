//
//  SizeableView.swift
//  Assignment5
//
//  Created by Narek on 10.10.24.
//

import SwiftUI

struct SizeableView: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}
