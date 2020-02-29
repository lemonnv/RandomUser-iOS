//
//  NavigationController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 29/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    //MARK: Object lifecycle
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Navigation bar
    
    private func setupNavigationBar() {
        navigationBar.backgroundColor = UIColor(named: "onSurface")
        navigationBar.titleTextAttributes = TextStyle.titlePrimaryCenter.attributes()
    }
    
}
