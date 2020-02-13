//
//  UsersListRouter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UsersListRouting: class {
    
}

class UsersListRouter: UsersListRouting {
    
    public weak var viewController: UIViewController?
    
    
    //MARK: Object lifecycle
    
    public init(viewController: UIViewController?) {
        
    }
}
