//
//  User.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Foundation

// MARK: - Response model

struct ResponseModel<T: Codable>: Codable {
    let results: T?
}

// MARK: - User

struct User: Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.phone == rhs.phone && lhs.name?.first == rhs.name?.first
            && lhs.name?.last == rhs.name?.last && lhs.name?.title == rhs.name?.title
    }

    let gender: String?
    let name: Name?
    let location: Location?
    let phone: String?
    let picture: Picture?
    let email: String?

    // MARK: - Init

    init(gender: String? = nil, name: Name? = nil, location: Location? = nil, phone: String? = nil, picture: Picture? = nil, email: String? = nil) {
        self.gender = gender
        self.name = name
        self.location = location
        self.phone = phone
        self.picture = picture
        self.email = email
    }

    // MARK: - Functions

    func hash(into hasher: inout Hasher) {
        let fullName = (name?.first ?? "") + (name?.last ?? "") + (name?.title ?? "")
        let phone = phone ?? ""
        let locationInfo = (location?.city ?? "") + (location?.country ?? "") + (location?.street?.name ?? "")
        let hashString = fullName + phone + locationInfo
        hasher.combine(hashString)
    }

    var fullName: String {
        let title = (name?.title ?? "")
        let firstName = (name?.first ?? "")
        let lastName = (name?.last ?? "")
        return title + " " + firstName + " " + lastName
    }

    var locationInfo: String {
        let street = (location?.street?.name ?? "") + " " + "\(location?.street?.number ?? 0)"
        let city = location?.city ?? ""
        let country = location?.country ?? ""
        return street + " " + city + " " + country
    }

    var imageURL: URL? {
        guard let url = URL(string: picture?.large ?? "") else { return nil }
        return url
    }

    func printUserInfo() {
        Console.log("User: \(fullName),\nLocation: \(locationInfo)")
    }
}

extension User {
    static let mockUser: User = .init(
        gender: "Male",
        name: .init(title: "Mr.", first: "John", last: "Smith"),
        location: .init(street: .init(number: 1, name: "Street"), city: "Wilmington", state: "Deleware", country: "USA"),
        phone: "1234567890",
        picture: nil,
        email: "wafaa.khodabaks@example.com"
    )
}

// MARK: - Picture

struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}

// MARK: - Street

struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Location

struct Location: Codable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
}

// MARK: - Name

struct Name: Codable {
    let title: String?
    let first: String?
    let last: String?
}
