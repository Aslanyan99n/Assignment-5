//
//  AppController.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Foundation

final class AppController: ObservableObject {
    enum Status {
        case authenticated
        case unauthenticated
    }
    
    static var shared = AppController()
    
    var environment: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
}
