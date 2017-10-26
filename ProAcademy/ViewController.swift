//
//  ViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 27/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        image.image? = (image.image?.withRenderingMode(.alwaysTemplate))!
        image.tintColor = UIColor.black
    }
    
}

