//
//  TabBarViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 03/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // It is hidden in Info.plist by default for launch screen
    override var prefersStatusBarHidden: Bool {
        return false
    }
    

}
