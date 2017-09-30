//
//  TrainingDetailsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class TrainingDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Perfekcyjne Brwi"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }


}
