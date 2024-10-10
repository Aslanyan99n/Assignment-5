//
//  NavigationRouter.swift
//  Assignment5
//
//  Created by User on 10.10.24.
//

import Foundation
import SwiftUI

protocol RouterInterface: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ screen: any Hashable)
    func pop()
    func popToRoot()
}

class NavigationRouter: RouterInterface {
    @Published var path = NavigationPath() {
        didSet {
            Console.log("Router navigationPath size \(path.count)")
        }
    }

    func resetNavigation(with destinations: [any Hashable]) {
        path = NavigationPath()
        destinations.forEach { destination in
            path.append(destination)
        }
    }

    func push(_ screen: any Hashable) {
        path.append(screen)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
