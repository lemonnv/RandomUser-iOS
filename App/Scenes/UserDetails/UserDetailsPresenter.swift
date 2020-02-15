//
//  UserDetailPresenter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UserDetailsPresentation: class {
    
}


class UserDetailsPresenter: UserDetailsPresentation {
    
    private weak var view: UserDetailsDisplay?
    private var router: UserDetailsRouting?
    
    
    //MARK: Object lifecycle
    
    public init(view: UserDetailsDisplay) {
        self.view = view
        router = resolve(argument: view.viewController)
    }
}
