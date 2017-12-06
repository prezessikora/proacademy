//
//  BookingViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 02/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    var training : Training?
    
    // user
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var location: UITextField!
    
    // training
    
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var trainingName: UILabel!
    @IBOutlet weak var trainingCost: UILabel!
    
    var bookingService : BookingService {
        get {
            return Utils.application().bookingService
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.isUserInteractionEnabled = false
        userEmail.isUserInteractionEnabled = false
        location.isUserInteractionEnabled = false
        
        trainingName.text = training?.title
        trainerName.text = training?.trainer
        
    }
    
    @IBAction func onBookEvent(_ sender: Any) {
        
        let bookingInProgress = UIAlertController.bookingAlert()
        bookingInProgress.presentInViewController(self)
        
        bookingService.performBooking(of: training!, completion: { result in
            switch (result) {
            case .success:
                bookingInProgress.dismiss(animated: true, completion: {
                    let success = UIAlertController.bookingConfirmation()
                    success.presentInViewController(self)
                })
            case .failure (let msg):
                bookingInProgress.dismiss(animated: true, completion: {
                    let alert = UIAlertController.bookingAlert(message: msg)
                    alert.presentInViewController(self)
                })
            }
        })
        

    }
}
