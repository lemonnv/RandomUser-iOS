//
//  UsersListPresenter.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

private let kVisibleUserCount = 10

protocol UsersListPresentation: class {
    func present(user: User)
    func loadUsers(fetchMore: Bool)
    func refresh()
}

class UsersListPresenter: UsersListPresentation {
    
    private weak var view: UsersListDisplay?
    private var router: UsersListRouting?

    private let getUsers = GetUsers()
    private let getNewUsers = GetNewUsers()
    
    private var users: [User] = []
    
    //MARK: Object lifecycle
    
    public init(view: UsersListDisplay) {
        self.view = view
        router = resolve(argument: view.viewController)
    }
    
    // MARK: Presentation
    
    func present(user: User) {
        self.router?.routeToDetail(user: user)
    }
    
    func loadUsers(fetchMore: Bool) {
        let count = max(kVisibleUserCount, users.count) + (fetchMore ? kVisibleUserCount : 0)
        self.view?.isLoading = true
        getUsers.run(params: GetUsers.Params(count: count)) { [weak self] result in
            self?.view?.isLoading = false
            if let error = result.error {
                self?.view?.display(error: error, animated: true)
            }
            let users = result.value ?? []
            self?.users = users
            self?.view?.display(users: users)
        }
    }
        
    func refresh() {
        self.users = []
        self.view?.isLoading = true
        self.view?.display(users: self.users)
        self.getNewUsers.run(params: GetUsers.Params(count: kVisibleUserCount)) { [weak self] result in
            self?.view?.isLoading = false
            if let error = result.error {
                self?.view?.display(error: error, animated: true)
            }
            let users = result.value ?? []
            self?.users = users
            self?.view?.display(users: users)
        }
    }
}
