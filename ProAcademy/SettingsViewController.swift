//
//  SettingsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 17/11/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var aboutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        let profile = SessionManager.shared.profile
        profile?.name
        nameTextField.delegate = self
        
        aboutButton.setImage(UIImage(named: "right arrow"), for: .normal)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Begin")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End")
    }
    
    @IBAction func onLogout(_ sender: Any) {
        _ = SessionManager.shared.logout()
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
