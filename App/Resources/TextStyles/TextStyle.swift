//
//  TextStyle.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 28/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

struct TextStyle {
    
    var font: UIFont
    var textAligment: NSTextAlignment
    var color: UIColor
    
}

extension TextStyle {
    
    static let titlePrimaryCenter = TextStyle(font: .systemFont(ofSize: 16, weight: .heavy), textAligment: .center, color: UIColor(named: "primary200")!)
    
    static let h3Left = TextStyle(font: .systemFont(ofSize: 15, weight: .semibold), textAligment: .left, color: UIColor(named: "onSurface200")!)
    
    static let bodyPrimaryLeft = TextStyle(font: UIFont.systemFont(ofSize: 13, weight: .regular), textAligment: .left, color: UIColor(named: "onSurface100")!)
    
}
