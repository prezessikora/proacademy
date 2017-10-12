//
//  Utils.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 03/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Utils  {
    static func imageFrom(systemItem: UIBarButtonSystemItem)-> UIImage? {
        let tempItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        // add to toolbar and render it
        UIToolbar().setItems([tempItem], animated: false)
        
        // got image from real uibutton
        let itemView = tempItem.value(forKey: "view") as! UIView
        for view in itemView.subviews {
            if let button = view as? UIButton, let imageView = button.imageView {
                return imageView.image
            }
        }
        
        return nil
    }
}
