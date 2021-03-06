//
//  UserResponse.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let data: [User]
}

struct User: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let picture: String
}

enum Gender: String, Decodable {
    case female
    case male
    case notDetemine
}

enum Title: String, Codable {
    case mrs
    case mr
    case ms
    case miss
    case dr
    case notDetemine = ""
}

struct Location: Codable {
    let street: String
    let timezone: String
    let state: String
    let country: String
}

struct UserProfile: Decodable {
    let id: String
    let gender: Gender
    let birthday: String
    let title: Title
    let lastName: String
    let firstName: String
    let email: String
    let pictureURL: String
    let phone: String
    let registerDate: String
    let location: Location
}

extension UserProfile {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case gender
        case birthday = "dateOfBirth"
        case title
        case lastName
        case firstName
        case email
        case pictureURL = "picture"
        case phone
        case registerDate
        case location
    }
}

extension UserProfile {
    var fullName: String {
        return title.rawValue.capitalized + " " + firstName + " " + lastName
    }
    
    var fullLocation: String {
        return location.street + " " + location.state + " " + location.country
    }
}

extension User {
    var fullName: String {
        return firstName + " " + lastName
    }
}

extension UserProfile {
    static func emptyProfile() -> UserProfile {
        let location = Location(street: "", timezone: "", state: "", country: "")
        return UserProfile(id: "", gender: .notDetemine, birthday: "", title: .notDetemine,
                           lastName: "", firstName: "", email: "", pictureURL: "",
                           phone: "", registerDate: "", location: location)
    }
}
