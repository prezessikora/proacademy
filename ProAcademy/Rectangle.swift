//
//  Rectangle.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 05/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

@IBDesignable
class Rectangle: UIView {

    
    @IBInspectable var color: UIColor = UIColor.red
    @IBInspectable var width: CGFloat = 5.0
    
    override func draw(_ rect: CGRect) {
        let rectangle = UIBezierPath(rect: rect)
        rectangle.lineWidth = width
        color.setStroke()
        rectangle.stroke()
    }
}
