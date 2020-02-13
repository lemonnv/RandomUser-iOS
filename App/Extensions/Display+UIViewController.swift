//
//  Display+UIViewController.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

extension Display {
    
    var viewController: UIViewController? {
        return self as? UIViewController
    }
    
    func result(from display: Display, data: Any?) {}
    
    func display(error: Error, animated: Bool) {
        let message = error.localizedDescription
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        viewController?.present(alertController, animated: animated, completion: nil)
    }
    
}
