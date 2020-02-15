//
//  UserDetailViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit


protocol UserDetailsDisplay: Display {
    func displayUser(_ user: User)
}


class UserDetailsViewController: UIViewController, UserDetailsDisplay {
    
    private var presenter: UserDetailsPresentation?
    
    private var userProperties: [(key: String, value: String)] = []
    
    //MARK: UI components
    
    private let tableView = UITableView().apply { tableView in
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: Object lifecycle
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        presenter = resolve(arguments: self as UserDetailsDisplay, user)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View lifecycle
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        self.setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
    
    
    //MARK: Display
    
    var screenName: String? = "UserDetails"
    
    func displayUser(_ user: User) {
        navigationItem.title = user.fullName
        userProperties = [
            (key: "First name", value: user.firstName),
            (key: "Last name", value: user.lastName),
            (key: "Email", value: user.email),
            (key: "Nationality", value: user.nationality),
            (key: "Phone", value: user.phoneNumber),
        ]
        tableView.reloadData()
    }
}

extension UserDetailsViewController: UITableViewDataSource {
    
    private static let kUserPropertyCell = "UserPropertyCell"
    
    private func setupTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsViewController.kUserPropertyCell) ?? UITableViewCell(style: .value1, reuseIdentifier: UserDetailsViewController.kUserPropertyCell)
        
        let property = userProperties[indexPath.row]
        cell.textLabel?.text = property.key
        cell.detailTextLabel?.text = property.value
        return cell
    }
}
