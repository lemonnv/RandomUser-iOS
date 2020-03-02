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
        imageView.layer.addSublayer(CAGradientLayer().apply {
            $0.colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 0.8).cgColor]
            $0.locations = [0.7]
        })
    }
    
    private let cityLabel = UILabel().apply { cityLabel in
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.numberOfLines = 1
    }
    
    private let streetAddress = UILabel().apply { streetAddress in
        streetAddress.translatesAutoresizingMaskIntoConstraints = false
        streetAddress.numberOfLines = 1
    }
    
    private let seperator = Separator(thickness: 1).apply { separator in
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var profileView = UIView().apply { profileView in
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(profileImageView)
        profileImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileImageView.leftAnchor.constraint(equalTo: profileView.leftAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1)
        ])
        
        profileView.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profileView.topAnchor),
            userName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            userName.rightAnchor.constraint(equalTo: profileView.rightAnchor)
        ])
        
        profileView.addSubview(userAge)
        NSLayoutConstraint.activate([
            userAge.topAnchor.constraint(equalTo: userName.bottomAnchor),
            userAge.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            userAge.rightAnchor.constraint(equalTo: profileView.rightAnchor),
            userAge.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            userAge.heightAnchor.constraint(equalTo: userName.heightAnchor, multiplier: 1)
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
        
    //MARK: Object lifecyle
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "surface")
        layer.masksToBounds = true
        layer.cornerRadius = 5
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 4.0)
        layer.shadowOpacity = 0.5
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            cityLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16)
        ])
        
        addSubview(streetAddress)
        NSLayoutConstraint.activate([
            streetAddress.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            streetAddress.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            streetAddress.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
        
        addSubview(seperator)
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: streetAddress.bottomAnchor, constant: 16),
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.sublayers?.first?.frame = imageView.bounds
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
        userAge.attributedText = .init(string: user != nil ? "\(user!.age) years old" : "", style: .bodyPrimaryLeft)
        
        cityLabel.attributedText = .init(string: (user != nil) ? "\(user!.address.city), \(user!.address.country)" : "", style: .h1InverseLeft)
        streetAddress.attributedText = .init(string: (user != nil) ? "\(user!.address.number) \(user!.address.streetName)" : "", style: .h3Left)
    }
    
}
