//
//  APIUser.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

enum APIUser: API.Model {
    
    typealias Params = Empty
    typealias Request = Empty
    typealias Response = Model
    
    struct Model: Codable {
        var name: Name
        var email: String
        var gender: String
        var dob: DateOfBirth
        var phone: String
        var nat: String
        var picture: Picture
        var location: Location
    }
    
    struct Name: Codable {
        var title: String
        var first: String
        var last: String
    }
    
    struct DateOfBirth: Codable {
        var date: String
        var age: Int
    }
    
    struct Picture: Codable {
        var thumbnail: String
        var medium: String
        var large: String
    }
    
    struct Location: Codable {
        var street: Street
        var city: String
        var country: String
        
        struct Street: Codable {
            var number: Int
            var name: String
        }
    }
        
    class Mapper: EntityMappable<Model, User> {

        override func to(entity type: APIUser.Model) -> User {
            let gender: Gender?
            switch type.gender {
            case "female":
                gender = .female
            case "male":
                gender = .male
            default:
                gender = nil
            }
            
            return User(
                email: type.email,
                firstName: type.name.first,
                lastName: type.name.last,
                gender: gender,
                age: type.dob.age,
                phoneNumber: type.phone,
                nationality: type.nat,
                picture: type.picture.entity,
                address: type.location.entity
            )
        }
        
    }
}

private extension APIUser.Picture {
    
    var entity: UserPicture? {
        UserPicture(
            thumbnail: URL(string: thumbnail)!,
            medium: URL(string: medium)!,
            large: URL(string: large)!
        )
    }
    
}

private extension APIUser.Location {
    
    var entity: Address {
        Address(number: street.number, streetName: street.name, city: city, country: country)
    }
    
}
