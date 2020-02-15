//
//  UserDetailViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit


protocol UserDetailsDisplay: Display {
    
}


class UserDetailsViewController: UIViewController, UserDetailsDisplay {
    
    private var presenter: UserDetailsPresentation?
    
    
    //MARK: UI components
    
    private let label = UILabel().apply { label in
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = resolve(argument: self as UserDetailsDisplay)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Display
    
    var screenName: String? = "UserDetails"
}
