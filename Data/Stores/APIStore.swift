//
//  APIStore.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 13/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

class APIStore {
    
    let client: APIClient = resolve()
    
}

extension APIStore: RemoteUserStore {
    
    func fetchUsers() throws -> [User] {
        let response = try client.getRandomUsers(APIUsersList.Params(results: 10)).accept(.ok).body!
        return APIUsersList.Mapper().to(entity: response)
    }
    
}
