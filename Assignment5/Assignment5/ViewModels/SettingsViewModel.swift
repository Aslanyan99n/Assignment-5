//
//  SettingsViewModel.swift
//  Assignment5
//
//  Created by User on 10.10.24.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    enum ColorType {
        case tintColor, backgroundColor
    }
    
    // MARK: - Properties
    
    @Published var isDarkMode: Bool = false
    @Published var isShowTintColorPicker: Bool = false
    @Published var isShowBackgroundColorPicker: Bool = false
    @Published var tintColor: Color = Color(hex: UserDefaults.tintColor)
    @Published var backgroundColor: Color = Color(hex: UserDefaults.backgroundColor)
    @Published var colorType: ColorType = .tintColor
}
