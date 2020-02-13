//
//  UsersListAssembly.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit
import Swinject

public class UsersListAssembly: Assembly {
    
    
    //MARK: Object lifecycle
    
    public init() {
        
    }
    
    
    //MARK: Assembly
    
    public func assemble(container: Container) {
        container.register(UsersListRouter.self) { (_, viewController) in UsersListRouter(viewController: viewController) }.implements(UsersListRouting.self)
        container.register(UsersListPresenter.self) { (_, view) in UsersListPresenter(view: view) }.implements(UsersListPresentation.self)
        container.register(UsersListViewController.self) { _ in UsersListViewController() }.implements(UsersListDisplay.self)
    }
}
