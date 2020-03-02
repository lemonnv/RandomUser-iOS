//
//  UsersListViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit
import Koloda

protocol UsersListDisplay: Display {
    var isLoading: Bool { get set }
    func display(users: [User])
}


class UsersListViewController: UIViewController, UsersListDisplay {
    
    private var presenter: UsersListPresentation?
    
    private var users: [User] = []
    
    //MARK: UI components
    
    private let activityIndicator = UIActivityIndicatorView(style: .large).apply { indicator in
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = UIColor(named: "primary200")
    }
    
    private let kolodaView = KolodaView().apply { koloda in
        koloda.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let buttonsView = UIStackView().apply { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
    }
    
    private let thumbUpButton = UIButton().apply { button in
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-thumb-up"), for: .normal)
    }
    
    private let thumbDownButton = UIButton().apply { button in
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-thumb-down"), for: .normal)
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
        
        navigationItem.title = "RandomRoommate"
        
        view.backgroundColor = UIColor(named: "background")
        setupKolodaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(kolodaView)
        NSLayoutConstraint.activate([
            kolodaView.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 24),
            kolodaView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 24),
            kolodaView.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -24)
        ])

        view.insertSubview(activityIndicator, at: 0)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: kolodaView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: kolodaView.centerXAnchor)
        ])
        
        view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalTo: kolodaView.bottomAnchor, constant: 48),
            buttonsView.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 48),
            buttonsView.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -48),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -48)
        ])
        
        thumbUpButton.addTarget(self, action: #selector(onTapThumb(sender:)), for: .touchUpInside)
        thumbDownButton.addTarget(self, action: #selector(onTapThumb(sender:)), for: .touchUpInside)
        
        buttonsView.addArrangedSubview(thumbDownButton)
        buttonsView.addArrangedSubview(thumbUpButton)
        
        self.presenter?.loadUsers(forceRefresh: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Actions
    
    @objc private func onTapThumb(sender: UIButton) {
        kolodaView.swipe((sender == thumbUpButton) ? .right : .left, force: true)
    }
    
    //MARK: Display
    
    var screenName: String? = "UsersList"
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
        
    func display(users: [User]) {
        self.users = users
        kolodaView.resetCurrentCardIndex()
    }
}

extension UsersListViewController: KolodaViewDelegate, KolodaViewDataSource {
        
    //MARK: Setup
    
    private func setupKolodaView() {
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.countOfVisibleCards = 3
    }
    
    // MARK: Data Source & Delegate
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        self.users.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let userCard = UserCardView()
        let user = self.users[index]
        userCard.image = UIImage(named: "image-appartment-1")
        userCard.user = user
        return userCard
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        self.presenter?.loadUsers(forceRefresh: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        self.presenter?.present(user: self.users[index])
    }
}

