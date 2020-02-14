//
//  APIUsersList.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

enum APIUsersList: API.Model {
    
    struct Params: Encodable {
        var results: Int
    }
    typealias Request = Empty
    
    struct Response: Decodable {
        var results: [APIUser.Model]
    }
 
    class Mapper: EntityMappable<Response, [User]> {
        
        override func to(entity type: APIUsersList.Response) -> [User] {
            let userMapper = APIUser.Mapper()
            return type.results.map { userMapper.to(entity: $0) }
        }
        
    }
}
