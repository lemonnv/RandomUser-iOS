//
//  UsersListRouter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UsersListRouting: class {
    func routeToDetail(user: User)
}

class UsersListRouter: UsersListRouting {
    
    public weak var viewController: UIViewController?
    
    
    //MARK: Object lifecycle
    
    public init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    //MARK: Routing
    
    func routeToDetail(user: User) {
        let userDetailsDisplay: UserDetailsDisplay = resolve()
        if let userDetailsViewController = userDetailsDisplay.viewController {
            self.viewController?.navigationController?.pushViewController(userDetailsViewController, animated: true)
        }
    }
}
