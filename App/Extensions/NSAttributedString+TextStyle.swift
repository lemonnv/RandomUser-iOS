//
//  NSAttributedString+TextStyle.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 28/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, style: TextStyle) {
        self.init(string: string, attributes: style.attributes())
    }
    
    func height(constrainedTo width: CGFloat) -> CGFloat {
        let rect = boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesDeviceMetrics.union(.usesFontLeading), context: nil)
        return rect.height
    }
    
    func width(constrainedTo height: CGFloat) -> CGFloat {
        let rect = boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin.union(NSStringDrawingOptions.usesFontLeading), context: nil)
        return rect.width
    }
    
}

extension TextStyle {
    
    func paragraphStyle() -> NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        
        style.alignment = textAligment
        style.lineBreakMode = .byTruncatingTail
//        style.lineHeightMultiple = lineSpacing/(font.pointSize*1.40)
        
        return style
    }
    
    func attributes() -> [NSAttributedString.Key:Any] {
        return [
//            NSAttributedString.Key.baselineOffset:1.0,
            NSAttributedString.Key.foregroundColor:self.color,
            NSAttributedString.Key.font:self.font,
//            NSAttributedString.Key.kern:self.characterSpacing,
            NSAttributedString.Key.paragraphStyle:self.paragraphStyle()
        ]
    }
}

