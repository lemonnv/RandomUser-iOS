//
//  Assemblies.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 13/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Swinject


class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(APIClient.self) { resolver in APIClient(authenticator: resolver.resolve()) }.inObjectScope(.container)
        container.register(APIStore.self) { _ in APIStore() }.implements(RemoteUserStore.self)
        
        container.register(UserPrefsStore.self) { _ in UserPrefsStore() }.implements(CacheUserStore.self)
        
        container.register(UserRepositoryLogic.self) { _ in UserRepository() }
    }
    
}

class AuthenticatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthenticatorLogic.self) { _ in DummyAuthenticator() }
    }
    
}
