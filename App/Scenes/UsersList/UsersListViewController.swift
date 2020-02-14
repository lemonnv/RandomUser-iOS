//
//  UsersListViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UsersListDisplay: Display {
    func display(users: [User])
}


class UsersListViewController: UIViewController, UsersListDisplay {
    
    private var presenter: UsersListPresentation?
    
    private var users: [User] = []
    
    //MARK: UI components
    
    private let tableView = UITableView().apply { tableView in
        
    }
    
    //MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = resolve(argument: self as UsersListDisplay)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View lifecycle
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    //MARK: Display
    
    var screenName: String? = "UsersList"
    
    func display(users: [User]) {
        self.users = users
        tableView.reloadData()
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private static let kUserCellIdentifier = "UserCell"
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UsersListViewController.kUserCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListViewController.kUserCellIdentifier, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.firstName) \(user.lastName)"
        return cell
    }
}
