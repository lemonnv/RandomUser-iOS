//
//  UserDetailAssembly.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit
import Swinject

public class UserDetailsAssembly: Assembly {
    
    
    //MARK: Object lifecycle
    
    public init() {
        
    }
    
    
    //MARK: Assembly
    
    public func assemble(container: Container) {
        container.register(UserDetailsRouter.self) { (_, viewController) in UserDetailsRouter(viewController: viewController) }.implements(UserDetailsRouting.self)
        container.register(UserDetailsPresenter.self) { (_, view, user) in UserDetailsPresenter(view: view, user: user) }.implements(UserDetailsPresentation.self)
        container.register(UserDetailsViewController.self) { _, user in UserDetailsViewController(user: user) }.implements(UserDetailsDisplay.self)
    }
}
