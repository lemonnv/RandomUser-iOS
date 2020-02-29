//
//  UIImageView+URL.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 29/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
    }
    
}
