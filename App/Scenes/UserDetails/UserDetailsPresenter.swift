//
//  UserDetailPresenter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UserDetailsPresentation: class {
    var user: User { get }
    func presentDialNumber()
}


class UserDetailsPresenter: UserDetailsPresentation {
    
    private weak var view: UserDetailsDisplay?
    private var router: UserDetailsRouting?
    
    var user: User
    
    //MARK: Object lifecycle
    
    public init(view: UserDetailsDisplay, user: User) {
        self.view = view
        self.user = user
        router = resolve(argument: view.viewController)
        
    }
    
    func presentDialNumber() {
        router?.routeToDialNumber(phone: user.phoneNumber)
    }
}
