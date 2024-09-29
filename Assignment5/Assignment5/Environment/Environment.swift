//
//  Environment.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Foundation

enum Environment: String {
    case production
    case development
    case local

    var baseURL: String {
        switch self {
        case .production: "https://randomuser.me/api"
        case .development: "https://randomuser.me/api"
        case .local: "https://randomuser.me/api"
        }
    }
}
