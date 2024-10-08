//
//  TargetType.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Moya
import UIKit

protocol MultiTargetType: TargetType {
    var parameters: Parameter { get }
}

typealias Parameter = [String: Any]
typealias Header = [String: String]

extension MultiTargetType {
    var baseURL: URL {
        guard let url = URL(string: AppController.shared.environment.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var parameters: Parameter {
        return [:]
    }
    
    var task: Task {
        return .requestPlain
    }

    var headers: Header? {
        var dict = [String: String]()
        dict["platform"] = UIDevice.current.systemName
        dict["systemVersion"] = UIDevice.current.systemVersion
        return dict
    }
}
