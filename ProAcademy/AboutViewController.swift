//
//  AboutViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 18/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class AboutViewController: TabBasedViewController {

    var aboutUsTab: Tab!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var aboutUsBar: UIView!
    @IBOutlet weak var aboutUsContainer: UIView!
    
    var faqTab: Tab!
    @IBOutlet weak var faqButton: UIButton!
    @IBOutlet weak var faqBar: UIView!
    @IBOutlet weak var faqContainer: UIView!
    
    var termsTab: Tab!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termsBar: UIView!
    @IBOutlet weak var termsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        aboutUsTab = Tab(button: aboutUsButton, bar: aboutUsBar, container: aboutUsContainer)
        faqTab = Tab(button: faqButton, bar: faqBar, container: faqContainer)
        termsTab = Tab(button: termsButton, bar: termsBar, container: termsContainer)

        changeState(active: aboutUsTab, inactive: faqTab,termsTab)
    }
    
    @IBAction func onAboutUs(_ sender: Any) {
        changeState(active: aboutUsTab, inactive: faqTab,termsTab)
    }
    
    @IBAction func onFaq(_ sender: Any) {
        changeState(active: faqTab, inactive: aboutUsTab,termsTab)
    }
    
    @IBAction func onTerms(_ sender: Any) {
        changeState(active: termsTab, inactive: aboutUsTab,faqTab)
    }
    
}


