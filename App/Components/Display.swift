//
//  Display.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

protocol Display: class {
    
    func result(from display: Display, data: Any?)

    func display(error: Error, animated: Bool)
    
}
