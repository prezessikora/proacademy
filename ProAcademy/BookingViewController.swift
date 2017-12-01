//
//  BookingViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    // user
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var location: UITextField!
    
    // training
    
    @IBOutlet weak var trainerName: UILabel!
    
    @IBOutlet weak var trainingName: UILabel!
    
    @IBOutlet weak var trainingCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.isUserInteractionEnabled = false
        userEmail.isUserInteractionEnabled = false
        location.isUserInteractionEnabled = false
    }
    
}
