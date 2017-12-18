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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var aboutButton: UIButton!
    

    override func viewDidLoad() {

        
        nameTextField.delegate = self
        emailTextField.delegate = self
        locationTextField.delegate = self
        
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.returnKeyType = .done
        emailTextField.clearButtonMode = .whileEditing
        locationTextField.clearButtonMode = .whileEditing
        
        aboutButton.setImage(UIImage(named: "right arrow"), for: .normal)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readProfile(toEmailTextField: emailTextField, toNameTextField: nameTextField, toLocationTextField: locationTextField)
    }
    
    
    func saveProfile(_ location: String) {
        SessionManager.shared.saveToMetadata(location: location)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // check for changes and only then save
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let locationString = locationTextField.text {
            saveProfile(locationString)
        }
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        _ = SessionManager.shared.logout()
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}

extension UIViewController {
    
    func readProfile(toEmailTextField emailTextField: UITextField, toNameTextField nameTextField: UITextField, toLocationTextField locationTextField: UITextField, missingEmail : String = "enter email", missingName : String = "enter name", missingLocation : String = "enter location city") {
        
        emailTextField.placeholder = "loading ..."
        nameTextField.placeholder = "loading ..."
        locationTextField.placeholder = "loading ..."
        
        let profile = SessionManager.shared.profile
        
        if let p = profile {
            
            if let profileEmail = p.email {
                emailTextField.text = profileEmail
            } else {
                emailTextField.text = ""
                emailTextField.placeholder = missingEmail
            }
            
            SessionManager.shared.readMetadata() { meta in
                DispatchQueue.main.async {
                    if let loc = meta["location"], let locationString = loc as? String {
                        locationTextField.text = locationString
                        
                    } else {
                        locationTextField.text = ""
                        locationTextField.placeholder = missingLocation
                    }
                    
                    if let fn = meta["first_name"], let sn = meta["last_name"], let firstName = fn as? String, let secondName = sn as? String {
                        nameTextField.text = firstName + " " + secondName
                    } else {
                        nameTextField.text = ""
                        nameTextField.placeholder = missingName
                    }
                }
            }
        }
        
    }

}
