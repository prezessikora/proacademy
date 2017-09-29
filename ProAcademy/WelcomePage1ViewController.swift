//
//  WelcomePage1ViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 29/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class WelcomePage1ViewController: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipButton.backgroundColor = UIColor.black
        
        skipButton.setTitleColor(.white, for: .normal)
    }

    

}
