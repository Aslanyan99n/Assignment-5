//
//  SettingsScreen.swift
//  Assignment5
//
//  Created by User on 10.10.24.
//

import SwiftUI

struct SettingsScreen: View {
    // MARK: - PROPERTIES
    
    typealias ViewModel = SettingsViewModel
    
    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false
    @StateObject var viewModel: ViewModel
    
    var textColor: Color {
        isDarkMode ? .white : .black
    }
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                Text(String.Text.settings)
                    .foregroundStyle(textColor)
                    .padding(.vertical, 12)
                
                Form {
                    appBackgroundColorRow
                    appTintColorRow
                    darkModeRow
                } //: FORM
            } //: VSTACK
            .background(isDarkMode ? Color.black : Color.white)
        }
        .colorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $viewModel.isShowTintColorPicker) {
            ColorPickerView(
                selectedColor: $viewModel.tintColor,
                colorType: .tintColor
            )
            .presentationDetents([.height(250)])
            .colorScheme(isDarkMode ? .dark : .light)
        }
        .sheet(isPresented: $viewModel.isShowBackgroundColorPicker) {
            ColorPickerView(
                selectedColor: $viewModel.backgroundColor,
                colorType: .backgroundColor
            )
            .presentationDetents([.height(250)])
            .colorScheme(isDarkMode ? .dark : .light)
        }
        .onAppear {
            viewModel.isDarkMode = isDarkMode
        }
    }
    
    // MARK: - APP BACKGROUND COLOR ROW
    
    var appBackgroundColorRow: some View {
        Button {
            viewModel.colorType = .backgroundColor
            viewModel.isShowBackgroundColorPicker = true
        } label: {
            HStack(spacing: 0) {
                Text(String.Text.backgroundColor)
                    .foregroundStyle(textColor)
                
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .fill(viewModel.backgroundColor)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    // MARK: - APP TINT COLOR ROW
    
    var appTintColorRow: some View {
        Button {
            viewModel.colorType = .tintColor
            viewModel.isShowTintColorPicker = true
        } label: {
            HStack(spacing: 0) {
                Text(String.Text.tintColor)
                    .foregroundStyle(textColor)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(viewModel.tintColor)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    // MARK: - DARK MODE ROW
    
    var darkModeRow: some View {
        Toggle(isOn: $viewModel.isDarkMode) {
            Text(String.Text.darkMode)
                .foregroundStyle(textColor)
        }
        .onChange(of: viewModel.isDarkMode) { value in
            isDarkMode = value
        }
    }
}

// MARK: - PREVIEW

#Preview {
    SettingsScreen(viewModel: SettingsViewModel())
}
