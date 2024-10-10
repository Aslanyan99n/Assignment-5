//
//  UsersViewModel.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    enum Screen: Hashable, Identifiable {
        case userDetails(viewModel: UserDetailsViewModel)
        
        var id: String {
            switch self {
            case .userDetails(let viewModel): Screen.userDetails(viewModel: viewModel).name
            }
        }
        
        var name: String {
            switch self {
            case .userDetails: "userDetails"
            }
        }
        
        static func == (lhs: UsersViewModel.Screen, rhs: UsersViewModel.Screen) -> Bool {
            lhs.id == rhs.id
        }
                
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
    }
    
    // MARK: - Properties
    
    @Published var isShowNetworkLog: Bool = false
    @Published var users: [User] = []
    @Published var itemsCountInRow: Int = 2
    @Published var isLoading: Bool = false
    @Published var page: Int = 0
    @Published var resultCount: Int = 10
    @Published var isList: Bool = false
    
    private let userEnvironment = Provider<UserEndpoint>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        $isList
            .sink { [weak self] isList in
                self?.itemsCountInRow = isList ? 1 : 2
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Functions
    
    func getUsers() async {
        do {
            page += 1
            isLoading = true
            let response: ResponseModel<[User]> = try await userEnvironment.request(.getUsers(page, resultCount))
            let users = response.results ?? []
            users.forEach { $0.printUserInfo() }
            self.users += users
            isLoading = false
        } catch {
            isLoading = false
            Console.log("Error: \(error.localizedDescription)")
        }
    }
    
    func reset() {
        page = 0
        users = []
    }
}
