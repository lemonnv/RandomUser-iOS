//
//  GetNewUsers.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 14/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import RxSwift

class GetNewUsers: CompletableInteractor<[User], GetUsers.Params> {
    
    override func buildSingle(params: GetUsers.Params) -> Single<[User]> {
        DeleteUsers().buildSingle(params: ())
            .flatMap { _ in GetUsers().buildSingle(params: params) }
    }
}
