//
//  UserRepository.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

protocol CacheUserStore {
    func setUsers(_ users: [User]) throws
    func getUsers() throws -> [User]?
}

protocol RemoteUserStore {
    func fetchUsers(size: Int) throws -> [User]
}

class UserRepository: UserRepositoryLogic {
    
    private let remoteStore: RemoteUserStore = resolve()
    private let cacheStore: CacheUserStore = resolve()
    
    func getUsers(count: Int) throws -> [User] {
        var cachedUsers = try cacheStore.getUsers()
        if cachedUsers == nil || cachedUsers!.count < count {
            cachedUsers = cachedUsers ?? []
            cachedUsers! += try remoteStore.fetchUsers(size: count - cachedUsers!.count)
            try cacheStore.setUsers(cachedUsers!)
        }
        return cachedUsers!
    }
    
    func deleteAll() throws {
        try cacheStore.setUsers([])
    }
    
}
