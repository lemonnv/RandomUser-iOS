//
//  UserCardView.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 29/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

class UserCardView: UIView {
    
    //MARK: UI Components
    
    private let imageView = UIImageView().apply { imageView in
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
    }
    
    private lazy var profileView = UIView().apply { profileView in
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileImageView.leftAnchor.constraint(equalTo: profileView.leftAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor)
        ])
        
        profileView.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profileView.topAnchor),
            userName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor),
            userName.rightAnchor.constraint(equalTo: profileView.rightAnchor)
        ])
        
        profileView.addSubview(userAge)
        NSLayoutConstraint.activate([
            userAge.topAnchor.constraint(equalTo: userName.bottomAnchor),
            userAge.leftAnchor.constraint(equalTo: profileImageView.rightAnchor),
            userAge.rightAnchor.constraint(equalTo: profileView.rightAnchor),
            userAge.bottomAnchor.constraint(equalTo: profileView.bottomAnchor)
        ])

    }
    
    private lazy var profileImageView = UserPictureView(size: .thumbnail).apply { view in
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var userName = UILabel().apply { label in
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var userAge = UILabel().apply { label in
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let seperator = UIView().apply { separator in
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(named: "primary100")
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //MARK: Object lifecyle
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "surface")
        layer.masksToBounds = true
        layer.cornerRadius = 5
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 4.0)
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])
        
        addSubview(seperator)
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            seperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            seperator.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 16),
            profileView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            profileView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public properties
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var user: User? { didSet { updateUser() } }
    
    //MARK: Update UI
    
    private func updateUser() {
        profileImageView.picture = user?.picture
        userName.attributedText = .init(string: user?.fullName ?? "", style: .h3Left)
        userAge.attributedText = .init(string: "25 years old", style: .bodyPrimaryLeft)
    }
    
}
