//
//  UserDetailViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 15/02/2020.
//  Copyright (c) 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

private let kLoremIpsumString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu semper velit. Nam tempor gravida libero, a gravida odio dapibus at. Donec sagittis neque lacus, vel posuere tortor volutpat et. Nulla ut tempor arcu. Quisque id sapien at augue elementum consequat. Vestibulum ac consequat quam."

protocol UserDetailsDisplay: Display {
}


class UserDetailsViewController: UIViewController, UserDetailsDisplay {
    
    private var presenter: UserDetailsPresentation?
    
    //MARK: UI Components
    
    private let closeButton = UIButton().apply { button in
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon-close"), for: .normal)
    }
    
    private let scrollView = UIScrollView().apply { scrollView in
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let stackView = UIStackView().apply { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
    }
    
    private lazy var addressView = UIView().apply { view in
        view.backgroundColor = UIColor(named: "surface")
        
        view.layoutMargins = .init(top: 26, left: 16, bottom: 16, right: 16)
        
        let user = self.presenter!.user
        
        let callButton = UIButton()
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.backgroundColor = UIColor(named: "primary200")
        callButton.setImage(UIImage(named: "icon-phone-call")!, for: .normal)
        callButton.layer.cornerRadius = 28
        callButton.layer.masksToBounds = true
        view.addSubview(callButton)
        NSLayoutConstraint.activate([
            callButton.heightAnchor.constraint(equalToConstant: 56),
            callButton.widthAnchor.constraint(equalToConstant: 56),
            callButton.centerYAnchor.constraint(equalTo: view.topAnchor),
            callButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
        callButton.addTarget(self, action: #selector(onTapCallButton), for: .touchUpInside)
        
        let cityName = UILabel()
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.attributedText = .init(string: "\(user.address.city), \(user.address.country)", style: .h4Left)
        view.addSubview(cityName)
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            cityName.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            cityName.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
        
        let streetName = UILabel()
        streetName.translatesAutoresizingMaskIntoConstraints = false
        streetName.attributedText = .init(string: "\(user.address.number) \(user.address.streetName)", style: .h2Left)
        view.addSubview(streetName)
        NSLayoutConstraint.activate([
            streetName.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 4),
            streetName.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            streetName.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            streetName.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        let separator = Separator(thickness: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            separator.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            separator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private let roomDescription = UIView().apply { view in
        view.backgroundColor = UIColor(named: "surface")
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.attributedText = .init(string: "Room description", style: .h3Left)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            title.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            title.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])

        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.attributedText = .init(string: kLoremIpsumString, style: .bodyPrimaryLeft)
        
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            description.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            description.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            description.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private lazy var amenitiesView = UIView().apply { view in
        view.backgroundColor = .clear
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.attributedText = .init(string: "Amenities", style: .h3Left)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            title.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            title.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(AmenityView(image: UIImage(named: "icon-wifi")!, text: "WiFi"))
        stackView.addArrangedSubview(AmenityView(image: UIImage(named: "icon-ac")!, text: "AC"))
        stackView.addArrangedSubview(AmenityView(image: UIImage(named: "icon-tv")!, text: "TV"))
        stackView.addArrangedSubview(AmenityView(image: UIImage(named: "icon-dog")!, text: "Pets allowed"))
        
    }
    
    private lazy var aboutView = UIView().apply { view in
        view.backgroundColor = UIColor(named: "surface")
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let user = self.presenter!.user
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.attributedText = .init(string: "About roommate", style: .h3Left)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            title.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            title.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
        
        let profileImage = UserPictureView(size: .medium)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.picture = user.picture
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            profileImage.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
        ])
        
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.attributedText = .init(string: user.fullName, style: .h3Left)
        view.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            userName.rightAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.rightAnchor),
            userName.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -2)
        ])
        
        let userAge = UILabel()
        userAge.translatesAutoresizingMaskIntoConstraints = false
        userAge.attributedText = .init(string: "\(user.age) years old", style: .bodyPrimaryLeft)
        view.addSubview(userAge)
        NSLayoutConstraint.activate([
            userAge.topAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 2),
            userAge.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            userAge.rightAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.rightAnchor)
        ])
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.attributedText = .init(string: kLoremIpsumString, style: .bodyPrimaryLeft)
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            description.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            description.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            description.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
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
        view.backgroundColor = UIColor(named: "background")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
        ])
        
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            closeButton.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 16),
            closeButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16)
        ])
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
        
        stackView.addArrangedSubview(UIImageView(image: UIImage(named: "image-appartment-1")))
        
        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(roomDescription)
        stackView.addArrangedSubview(amenitiesView)
        stackView.addArrangedSubview(aboutView)
        
    }
    
    //MARK: Actions

    @objc private func onTapCloseButton() {
        presenter?.close()
    }
    
    @objc private func onTapCallButton() {
        presenter?.presentDialNumber()
    }

    //MARK: Display
    
    var screenName: String? = "UserDetails"
    
}

private class AmenityView: UIView {
    
    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(named: "surface")
        imageView.tintColor = UIColor(named: "primary300")
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = .init(string: text, style: .bodyPrimaryCenter)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
