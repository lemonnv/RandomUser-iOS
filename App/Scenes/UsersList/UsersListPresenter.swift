//
//  UsersListPresenter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UsersListPresentation: class {
    func present(user: User)
    func loadMoreUsers()
}


class UsersListPresenter: UsersListPresentation {
    
    private weak var view: UsersListDisplay?
    private var router: UsersListRouting?

    private let getUsersList = GetUsersList()
    
    //MARK: Object lifecycle
    
    public init(view: UsersListDisplay) {
        self.view = view
        router = resolve(argument: view.viewController)
        
        getUsersList.run(params: .default) { [weak self] result in
            if let error = result.error {
                self?.view?.display(error: error, animated: true)
            }
            self?.view?.display(users: result.value ?? [])
        }
    }
    
    // MARK: Presentation
    
    func present(user: User) {
        
    }
    
    func loadMoreUsers() {
        getUsersList.run(params: .fetchMore) { [weak self] result in
            if let error = result.error {
                self?.view?.display(error: error, animated: true)
            }
            self?.view?.display(users: result.value ?? [])
        }
    }
}
