//
//  AboutUsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 20/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var aboutUsText: UITextView!
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsText.backgroundColor = AboutUsUI.backgroundColor
        image.backgroundColor = AboutUsUI.backgroundColor
    }

}
