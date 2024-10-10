//
//  WidthPreferenceKey.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
