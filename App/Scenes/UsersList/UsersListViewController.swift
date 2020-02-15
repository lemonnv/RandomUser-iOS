//
//  UsersListViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

protocol UsersListDisplay: Display {
    var isLoading: Bool { get set }
    var visibleCellCount: Int { get }
    func display(users: [User])
}


class UsersListViewController: UIViewController, UsersListDisplay {
    
    private var presenter: UsersListPresentation?
    
    private var users: [User] = []
    
    //MARK: UI components
    
    private let refreshControl = UIRefreshControl()
    
    private let tableView = UITableView(frame: .zero, style: .grouped).apply { tableView in
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        navigationItem.title = "RandomUser"
        
        view.backgroundColor = .white
        setupTableView()
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
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.loadUsers(fetchMore: false)
    }
    
    //MARK: Actions
    
    @objc private func pullToRefresh() {
        self.presenter?.refresh()
    }
    
    private func loadMoreCellWillDisplay() {
        self.presenter?.loadUsers(fetchMore: true)
    }
    
    private func didSelectUser(user: User) {
        self.presenter?.present(user: user)
    }
    
    //MARK: Display
    
    var screenName: String? = "UsersList"
    
    var isLoading: Bool = false {
        didSet {
            isLoading ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
        }
    }
    
    var visibleCellCount: Int {
        30
    }
    
    func display(users: [User]) {
        self.users = users
        tableView.reloadData()
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Cells
    
    private static let kUserCellIdentifier = "UserCell"
    
    private class UserCell: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            accessoryType = .disclosureIndicator
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    private static let kLoadMoreCellIdentifier = "LoadMoreCell"
    
    private class LoadMoreCell: UITableViewHeaderFooterView {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium).apply { indicator in
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.color = .black
            indicator.hidesWhenStopped = false
        }
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            contentView.backgroundColor = .clear

            contentView.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                activityIndicator.widthAnchor.constraint(equalToConstant: 30),
                activityIndicator.heightAnchor.constraint(equalToConstant: 30)
            ])

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    //MARK: Setup
    
    private func setupTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UserCell.self, forCellReuseIdentifier: UsersListViewController.kUserCellIdentifier)
        self.tableView.register(LoadMoreCell.self, forHeaderFooterViewReuseIdentifier: UsersListViewController.kLoadMoreCellIdentifier)
    }
    
    // MARK: Data Source & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListViewController.kUserCellIdentifier, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.fullName
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.users.count > 0 ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard self.users.count > 0 else { return nil }
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UsersListViewController.kLoadMoreCellIdentifier)
        return footer
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let loadMoreCell = view as? LoadMoreCell else { return }
        
        loadMoreCell.activityIndicator.startAnimating()
        self.loadMoreCellWillDisplay()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        didSelectUser(user: user)
    }
}

