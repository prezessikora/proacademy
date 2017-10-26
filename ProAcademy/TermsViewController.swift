//
//  TermsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 20/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var termsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        termsText.backgroundColor = AboutUsUI.backgroundColor
    }

   

}
