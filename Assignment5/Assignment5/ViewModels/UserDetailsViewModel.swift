//
//  UserDetailsViewModel.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import Combine
import Foundation

@MainActor
final class UserDetailsViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var user: User
    @Published var isAnimated: Bool = false
    @Published var isShowSettings: Bool = false
    
    var id = UUID()
    
    init(user: User) {
        self.user = user
    }
}
