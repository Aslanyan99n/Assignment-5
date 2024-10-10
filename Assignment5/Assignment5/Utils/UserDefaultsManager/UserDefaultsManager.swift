//
//  UserDefaultsManager.swift
//  Assignment5
//
//  Created by Narek on 10.10.24.
//

import Combine
import Foundation
import SwiftUICore

extension UserDefaults {
    @UserDefault(key: "tintColor", defaultValue: "#000000")
    static var tintColor: String
    
    @UserDefault(key: "backgroundColor", defaultValue: "#B5E2FF")
    static var backgroundColor: String
}

// MARK: - UserDefault

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    private let publisher = PassthroughSubject<Value, Never>()

    lazy var container: UserDefaults = .standard

    var wrappedValue: Value {
        mutating get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                publisher.send(newValue)
                container.set(newValue, forKey: key)
            }
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
}

// MARK: - UserDefaultCodable

@propertyWrapper
struct UserDefaultCodable<Value: Codable> {
    let key: String
    let defaultValue: Value?
    private let publisher = PassthroughSubject<Value, Never>()

    lazy var userDefaultsSuite: UserDefaults = .init(suiteName: "group.com.assignment5") ?? .standard

    public var wrappedValue: Value? {
        mutating get {
            if let data = userDefaultsSuite.object(forKey: key) as? Data,
               let orgVal = try? JSONDecoder().decode(Value.self, from: data)
            {
                return orgVal
            } else {
                return defaultValue
            }
        }
        set {
            if let newValue = newValue {
                if let data = try? JSONEncoder().encode(newValue) {
                    userDefaultsSuite.set(data, forKey: key)
                }
            } else {
                userDefaultsSuite.set(newValue, forKey: key)
            }
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
}

extension UserDefault where Value: ExpressibleByNilLiteral {
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}
