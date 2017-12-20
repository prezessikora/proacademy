//
//  RoundButton.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 20/12/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

@IBDesignable public class RoundButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 10.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.1 * bounds.size.width
        clipsToBounds = true
    }
}
