//
//  ColorPickerView.swift
//  Assignment5
//
//  Created by Narek on 10.10.24.
//

import SwiftUI

struct ColorPickerView: View {
    // MARK: - PROPERTIES

    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false
    @State private var colorHex: String = "#FFFFFF"
    @Binding var selectedColor: Color

    var colorType: SettingsScreen.ViewModel.ColorType

    // MARK: - BODY

    var body: some View {
        VStack(spacing: 10) {
            ColorPicker(String.Text.pickColor, selection: $selectedColor)
                .padding()

            Text(String.Text.hexColor + colorHex)
                .font(.headline)
                .foregroundStyle(isDarkMode ? Color.white : Color.black)
                .padding()

            ZStack {
                Rectangle()
                    .background(.ultraThinMaterial)
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                
                Rectangle()
                    .fill(selectedColor)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            if colorType == .tintColor {
                colorHex = UserDefaults.tintColor
            } else {
                colorHex = UserDefaults.backgroundColor
            }
            selectedColor = Color(hex: colorHex)
        }
        .onChange(of: selectedColor) { newColor in
            colorHex = newColor.colorToHex
            Console.log("HEX: \(colorHex)")
            if colorType == .tintColor {
                UserDefaults.tintColor = colorHex
            } else {
                UserDefaults.backgroundColor = colorHex
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ColorPickerView(
        selectedColor: .constant(Color.red),
        colorType: .tintColor
    )
}
