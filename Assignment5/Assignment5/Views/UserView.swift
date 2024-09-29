//
//  UserView.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import NukeUI
import SwiftUI

struct UserView: View {
    // MARK: - Body

    let user: User
    let width: CGFloat
    let height: CGFloat

    var url: URL? {
        guard let url = URL(string: user.picture?.large ?? "") else { return nil }
        return url
    }

    var body: some View {
        VStack(spacing: 0) {
            image
            userInfoView
        } //: VSTACK
        .cornerRadius(radius: 8, corners: .allCorners)
    }

    // MARK: - Image

    var image: some View {
        LazyImage(url: url) { state in
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
    }
    
    // MARK: - UserInfoView
    
    var userInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(user.getUserFullName())
                .font(.headline)
                .foregroundStyle(.black)
            
            Text(user.getUserLocationInfo())
                .font(.subheadline)
                .foregroundStyle(.black)
        } //: VSTACK
        .frame(height: 100)
    }
}

// MARK: - Preview

#Preview {
    UserView(user: User(), width: 40, height: 60)
}
