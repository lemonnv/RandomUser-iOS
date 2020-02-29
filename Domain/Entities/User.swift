//
//  User.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

public enum Gender {
    case male, female
}

extension Gender: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .male
        case 1:
            self = .female
        default:
            throw CodingError.unknownValue
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .male:
            try container.encode(0, forKey: .rawValue)
        case .female:
            try container.encode(1, forKey: .rawValue)
        }
    }
}

public struct UserPicture: Codable {
    var thumbnail: URL
    var medium: URL
    var large: URL
}

public struct User: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String { "\(firstName) \(lastName)" }
    var gender: Gender?
    var phoneNumber: String
    var nationality: String
    var picture: UserPicture?
    
}
