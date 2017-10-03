//
//  BookingViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
  
}
