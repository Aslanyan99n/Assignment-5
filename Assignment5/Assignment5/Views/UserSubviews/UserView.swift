//
//  UserView.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import NukeUI
import SwiftUI

struct UserView: View {
    // MARK: - Properties
    
    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false

    let user: User
    let width: CGFloat
    let height: CGFloat

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            image
            userInfoView
        } //: VSTACK
    }

    // MARK: - Image

    var image: some View {
        LazyImage(url: user.imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                BlinkingPlaceholder()
            }
        }
        .frame(width: abs(width), height: abs(height))
        .clipped(antialiased: true)
        .cornerRadius(radius: 8, corners: .allCorners)
    }

    // MARK: - UserInfoView

    var userInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(user.fullName)
                .font(.headline)
                .foregroundStyle(isDarkMode ? Color.white : Color.black)

            Text(user.locationInfo)
                .font(.subheadline)
                .foregroundStyle(isDarkMode ? Color.white : Color.black)

        } //: VSTACK
        .frame(height: 100)
    }
}

// MARK: - Preview

#Preview {
    UserView(user: User(), width: 40, height: 60)
}
