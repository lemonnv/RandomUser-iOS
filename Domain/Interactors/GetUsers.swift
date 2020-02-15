//
//  GetUsersList.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import RxSwift

public class GetUsers: CompletableInteractor<[User], GetUsers.Params> {
    
    //MARK: Params
    
    public struct Params {
        var count: Int
    }
    
    private let userRepository: UserRepositoryLogic = resolve()
    
    //MARK: Object lifecycle
    
    public override init() {
        super.init()
    }
    
    //MARK: Interactor
    
    override func buildSingle(params: GetUsers.Params) -> Single<[User]> {
        single { try self.userRepository.getUsers(count: params.count) }
    }
}
