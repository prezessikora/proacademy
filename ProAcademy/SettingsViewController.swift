//
//  SettingsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 17/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        let profile = SessionManager.shared.profile
        profile?.name
        
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        _ = SessionManager.shared.logout()
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
