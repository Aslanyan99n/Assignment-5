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
    
    @StateObject private var usersVM = UsersViewModel()
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                buttonsStackView
                GeometryReader { geo in
                    ScrollView(.vertical, showsIndicators: false) {
                        UsersGridView(
                            itemsCountInRow: $usersVM.itemsCountInRow,
                            users: usersVM.users,
                            width: geo.size.width,
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
            } //: VSTACK
        } //: ZSTACK
        .animation(.default, value: usersVM.isList)
        .isLoading(usersVM.isLoading)
        .onAppear {
            Task {
                await usersVM.getUsers()
            }
        }
        .onShake {
            #if DEBUG
            usersVM.isShowNetworkLog = true
            Console.log("LOGGER STARTED")
            #endif
        }
        .sheet(isPresented: $usersVM.isShowNetworkLog) {
            NavigationView {
                ConsoleView()
            }
        }
    }
    
    // MARK: - ButtonsStackView
    
    var buttonsStackView: some View {
        HStack(spacing: 0) {
            Spacer()
            listButton
            Spacer().frame(width: 8)
            gridButton
        } //: HSTACK
        .padding(16)
    }
    
    // MARK: - ListButton

    var listButton: some View {
        Button {
            if !usersVM.isList {
                usersVM.isList.toggle()
            }
        } label: {
            Image(systemName: "list.bullet")
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(usersVM.isList ? .black : .gray)
        }
    }
    
    // MARK: - GridButton

    var gridButton: some View {
        Button {
            if usersVM.isList {
                usersVM.isList.toggle()
            }
        } label: {
            Image(systemName: "square.grid.2x2")
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(!usersVM.isList ? .black : .gray)
        }
    }
}

// MARK: - Preview

#Preview {
    UsersScreen()
}
