//
//  UserPrefsStore.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 13/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

class UserPrefsStore {
    
    private let userDefaults = UserDefaults.standard
    
}

private let kUsersKey = "users"

extension UserPrefsStore: CacheUserStore {
    
    func setUsers(_ users: [User]) throws {
        let data = try JSONEncoder().encode(users)
        self.userDefaults.set(data, forKey: kUsersKey)
    }
    
    func getUsers() throws -> [User]? {
        if let data = self.userDefaults.object(forKey: kUsersKey) as? Data {
            return try JSONDecoder().decode([User].self, from: data)
        }
        return nil
    }
}
