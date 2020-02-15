//
//  APIUser.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

enum APIUser: API.Model {
    
    typealias Params = Empty
    typealias Request = Empty
    typealias Response = Model
    
    struct Model: Codable {
        var name: Name
        var email: String
        var gender: String
        var phone: String
        var nat: String
    }
    
    struct Name: Codable {
        var title: String
        var first: String
        var last: String
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
                phoneNumber: type.phone,
                nationality: type.nat)
        }
        
    }
}
