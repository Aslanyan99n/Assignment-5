//
//  UserEndpoint.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Moya

enum UserEndpoint {
    case getUsers(_ page: Int, _ results: Int)
}

extension UserEndpoint: MultiTargetType {
    var path: String {
        switch self {
        case .getUsers: ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUsers: .get
        }
    }

    var parameters: Parameter {
        switch self {
        case let .getUsers(page, results):
            return [
                "page": page,
                "results": results
            ]
        }
    }

    var task: Task {
        switch self {
        case .getUsers: .requestParameters(parameters: parameters, encoding: URLEncoding())
        }
    }
}
