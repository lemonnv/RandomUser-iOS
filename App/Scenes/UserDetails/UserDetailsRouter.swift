//
//  UserDetailRouter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UserDetailsRouting: class {
    func routeToDialNumber(phone: String)
}

class UserDetailsRouter: UserDetailsRouting {
    
    public weak var viewController: UIViewController?
    
    
    //MARK: Object lifecycle
    
    public init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func routeToDialNumber(phone: String) {
        UIApplication.shared.open(URL(string: "tel://\(phone)")!)
    }
}
