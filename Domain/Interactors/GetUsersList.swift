//
//  GetUsersList.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import RxSwift

public class GetUsersList: CompletableInteractor<[User], GetUsersList.Action> {
    
    //MARK: Params
    
    public enum Action {
        case `default`
        case fetchMore
    }
    
    private let userRepository: UserRepositoryLogic = resolve()
    
    //MARK: Object lifecycle
    
    public override init() {
        super.init()
    }
    
    //MARK: Interactor
    
    override func buildSingle(params: GetUsersList.Action) -> Single<[User]> {
        single { try self.userRepository.getUsers(fetchMore: params == .fetchMore) }
    }
}
