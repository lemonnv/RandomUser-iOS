//
//  APIClient+User.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

extension APIClient {
    
    func getRandomUsers(_ params: APIUsersList.Params) throws -> API.Response<APIUsersList> {
        try get(domain: .user, action: nil, query: params)
    }
    
}
