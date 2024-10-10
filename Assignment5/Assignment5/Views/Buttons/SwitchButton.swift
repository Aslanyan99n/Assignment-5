//
//  SwitchButton.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

struct SwitchButton: View {
    // MARK: - PROPERTIES

    @Binding var isList: Bool
    
    var tintColor: Color {
        Color(hex: UserDefaults.tintColor)
    }

    // MARK: - BODY

    var body: some View {
        ZStack {
            Capsule()
                .fill(.ultraThinMaterial)
                .frame(width: 72, height: 38)
            HStack(spacing: 0) {
                ZStack {
                    Capsule()
                        .fill(Color.yellow)
                        .frame(width: 32, height: 32)
                        .offset(x: isList ? 0 : 33)
                        .animation(.easeOut(duration: 0.3), value: isList)

                    listButton
                } //: ZSTACK
                ZStack {
                    Capsule()
                        .fill(.clear)
                        .frame(width: 32, height: 32)

                    gridButton
                } //: ZSTACK
            } //: HSTACK
        } //: ZSTACK
    }
    
    // MARK: - LIST BUTTON
    
    var listButton: some View {
        Button {
            if !isList {
                isList.toggle()
            }
        } label: {
            Image(systemName: "list.bullet")
                .renderingMode(.template)
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(tintColor)
        }
    }
    
    // MARK: - GRID BUTTON
    
    var gridButton: some View {
        Button {
            if isList {
                isList.toggle()
            }
        } label: {
            Image(systemName: "square.grid.2x2")
                .renderingMode(.template)
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(tintColor)
        }
    }
}

// MARK: - PREVIEW

#Preview {
    SwitchButton(isList: .constant(false))
}
