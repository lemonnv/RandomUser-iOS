//
//  UserRepositoryLogic.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

public protocol UserRepositoryLogic {
    func getUsers(count: Int) throws -> [User]
    func deleteAll() throws
}
