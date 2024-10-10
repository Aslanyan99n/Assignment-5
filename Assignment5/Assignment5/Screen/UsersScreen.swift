//
//  UsersScreen.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import PulseUI
import SwiftUI

struct UsersScreen: View {
    // MARK: - Properties

    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false
    @StateObject private var usersVM = UsersViewModel()
    @StateObject private var router = NavigationRouter()
    
    private var backgroundColor: Color {
        Color(hex: UserDefaults.backgroundColor)
    }

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    navigationBar
                    contentView
                } //: VSTACK
            } //: ZSTACK
            .animation(.default, value: usersVM.isList)
            .isLoading(usersVM.isLoading)
            .colorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                Task {
                    await usersVM.getUsers()
                }
            }
            .onShake {
                #if DEBUG
                usersVM.isShowNetworkLog = true
                #endif
            }
            .sheet(isPresented: $usersVM.isShowNetworkLog) {
                NavigationView {
                    ConsoleView()
                }
            }
            .navigationDestination(for: UsersViewModel.Screen.self) { screen in
                switch screen {
                case let .userDetails(viewModel): UserDetailsScreen(viewModel: viewModel)
                }
            }
        } //: NAVIGATION STACK
        .environmentObject(router)
    }
    
    // MARK: - NAVIGATION BAR
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 72)
            Spacer()
            
            Text(String.Text.users)
                .font(.title)
                .foregroundStyle(isDarkMode ? .white : .black)
                .padding(.vertical, 12)
            
            Spacer()
            
            SwitchButton(isList: $usersVM.isList)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(backgroundColor)
    }

    // MARK: - CONTENT VIEW

    var contentView: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                Spacer().frame(height: 16)
                UsersGridView(
                    itemsCountInRow: $usersVM.itemsCountInRow,
                    users: usersVM.users,
                    width: geo.size.width,
                    onTapAction: { user in
                        let screen = UsersViewModel.Screen.userDetails(viewModel: UserDetailsViewModel(user: user))
                        router.push(screen)
                    },
                    loadMoreAction: {
                        if usersVM.page <= 5 {
                            Task {
                                await usersVM.getUsers()
                            }
                        }
                    }
                )
            } //: ScrollView
            .refreshable {
                usersVM.reset()
                Task {
                    await usersVM.getUsers()
                }
            }
        } //: GeometryReader
        .background(isDarkMode ? .black : .white)
    }
}

// MARK: - Preview

#Preview {
    UsersScreen()
}
