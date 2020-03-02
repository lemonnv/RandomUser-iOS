//
//  Separator.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 02/03/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

class Separator: UIView {
    
    enum Axis {
        case vertical
        case horizontal
    }

    let thickness: CGFloat
    let axis: Axis
    
    init(thickness: CGFloat, axis: Axis = .horizontal) {
        self.thickness = thickness
        self.axis = axis
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "primary100")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        switch axis {
        case .horizontal:
            return CGSize(width: 0.0, height: thickness)
        case .vertical:
            return CGSize(width: thickness, height: 0.0)
        }
    }
    
}
