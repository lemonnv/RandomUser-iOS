//
//  UserPictureView.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 29/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

class UserPictureView: UIImageView {
    
    enum Size {
        case thumbnail
        case medium
        case large
    }
    
    let size: Size
    
    var picture: UserPicture? {
        didSet {
            updatePictureImage()
        }
    }
    
    init(size: Size) {
        self.size = size
        super.init(image: nil)
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = max(frame.width, frame.height) / 2
    }
    
    private func updatePictureImage() {
        guard let picture = self.picture else {
            self.image = nil
            return
        }
        
        let url: URL
        switch size {
        case .thumbnail:
            url = picture.thumbnail
        case .medium:
            url = picture.medium
        case .large:
            url = picture.large
        }
        load(url: url)
    }
}
