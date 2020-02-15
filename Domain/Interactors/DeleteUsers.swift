//
//  DeleteUsers.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 14/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import RxSwift
import Swinject

public class DeleteUsers: CompletableInteractor<Void, Void> {

    private let userRepository: UserRepositoryLogic = resolve()
    
    override func buildSingle(params: Void) -> Single<Void> {
        single {
            try self.userRepository.deleteAll()
        }
    }
    
}
