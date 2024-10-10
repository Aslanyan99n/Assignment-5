//
//  UserDetailsScreen.swift
//  Assignment5
//
//  Created by Narek on 08.10.24.
//

import NukeUI
import SwiftUI

struct UserDetailsScreen: View {
    // MARK: - Properties
    
    typealias ViewModel = UserDetailsViewModel
    
    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var router: NavigationRouter
    
    private var tintColor: Color {
        Color(hex: UserDefaults.tintColor)
    }
    
    private var backGroundColor: Color {
        Color(hex: UserDefaults.backgroundColor)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            contentBackGroundView
                .ignoresSafeArea()
            contentView
        } //: ZSTACK
        .colorScheme(isDarkMode ? .dark : .light)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $viewModel.isShowSettings) {
            SettingsScreen(viewModel: SettingsViewModel())
        }
    }
    
    // MARK: - Content View
    
    var contentView: some View {
        VStack(spacing: 0) {
            navigationBar
                .padding(.horizontal, 16)
                .zIndex(2)
            profileImage
                .zIndex(1)
            
            Spacer().frame(height: 20)
            
            userInfoSection
        }
        .background(.clear)
    }
    
    // MARK: - Content Background View
    
    var contentBackGroundView: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                backGroundColor
                    .frame(width: geo.size.width, height: geo.size.height * 0.3)
                if isDarkMode {
                    Color.black
                        .frame(width: geo.size.width, height: geo.size.height * 0.7)
                } else {
                    Color.white
                        .frame(width: geo.size.width, height: geo.size.height * 0.7)
                }
            }
        }
    }
    
    // MARK: - Navigation Bar
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            backButton
            Spacer()
            settingsButton
        } //: HSTACK
    }
    
    // MARK: - Profile image
    
    var profileImage: some View {
        LazyImage(url: viewModel.user.imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                SkeletonView()
            }
        }
        .frame(width: 250, height: 250)
        .clipped(antialiased: true)
        .clipShape(Circle())
        .padding(8)
        .background(Color.white)
        .clipShape(Circle())
        .offset(x: 0, y: viewModel.isAnimated ? 0 : -125)
        .shadow(color: .black.opacity(0.3), radius: 5)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                viewModel.isAnimated.toggle()
            }
        }
        .overlay {
            CircularTextView(radius: 100, text: viewModel.user.fullName)
                .frame(width: 320, height: 320, alignment: .center)
                .offset(x: 0, y: viewModel.isAnimated ? 0 : -125)
        }
    }
    
    // MARK: - Back Button
    
    var backButton: some View {
        Button {
            // ACTION
            router.pop()
        } label: {
            Image(systemName: "chevron.backward.circle")
                .renderingMode(.template)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(tintColor)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
    
    // MARK: - Settings Button
    
    var settingsButton: some View {
        Button {
            // ACTION
            viewModel.isShowSettings = true
        } label: {
            Image(systemName: "gear")
                .renderingMode(.template)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(tintColor)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
    
    // MARK: - User info Section
    
    var userInfoSection: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)
                
            userInfoContentView
                .padding(.horizontal, 16)
            Spacer()
        } //: VSTACK
    }
    
    // MARK: - User Info Content View
    
    var userInfoContentView: some View {
        VStack(spacing: 0) {
            if let gender = viewModel.user.gender, !gender.isEmpty {
                UserInfoRow(infoType: .gender, info: gender)
                    .offset(x: viewModel.isAnimated ? 0 : -100)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.isAnimated)
            }
            UserInfoRow(infoType: .location, info: viewModel.user.locationInfo)
                .offset(x: viewModel.isAnimated ? 0 : -150)
                .animation(.easeInOut(duration: 1), value: viewModel.isAnimated)
            if let phone = viewModel.user.phone, !phone.isEmpty {
                UserInfoRow(infoType: .phoneNumber, info: phone)
                    .offset(x: viewModel.isAnimated ? 0 : -200)
                    .animation(.easeInOut(duration: 1.5), value: viewModel.isAnimated)
            }
            if let email = viewModel.user.email, !email.isEmpty {
                UserInfoRow(infoType: .email, info: email, hasDiveder: false)
                    .offset(x: viewModel.isAnimated ? 0 : -250)
                    .animation(.easeInOut(duration: 2), value: viewModel.isAnimated)
            }
        } //: VSTACK
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
//        .background(Color.white)
        .background(isDarkMode ? .gray.opacity(0.3) : .white)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .padding(.horizontal, 1)
        }
        .compositingGroup()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.gray.opacity(0.3), radius: 5)
    }
}

// MARK: - Preview

#Preview {
    UserDetailsScreen(viewModel: UserDetailsViewModel(user: User.mockUser))
}
