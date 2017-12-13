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
    
    @IBOutlet weak var bookTrainingButton: UIButton!
    
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
        if let t = training {
            trainingName.text = t.title
            trainerName.text = t.trainer
            trainingCost.text = "\(t.price!) PLN"
        }
    }
    
    
    
    func disableBookingButton() {
        bookTrainingButton.isEnabled = false
        bookTrainingButton.titleLabel?.text = "Szkolenie zarezerwowane"
    
    }
    
    @IBAction func onBookEvent(_ sender: Any) {
        
        let bookingInProgress = UIAlertController.bookingAlert()
        bookingInProgress.presentInViewController(self)
        
        bookingService.performBooking(of: training!, completion: { result in
            switch (result) {
            case .success:
                print("Training booking - SUCCESS")
                bookingInProgress.dismiss(animated: true, completion: {
                    let success = UIAlertController.bookingConfirmation()
                    success.presentInViewController(self)
                })
                disableBookingButton()
            case .failure (let msg):
                print("Training booking - FAILED: \(msg)")
                bookingInProgress.dismiss(animated: true, completion: {
                    let alert = UIAlertController.bookingAlert(message: msg)
                    alert.presentInViewController(self)
                })
            }
        })
        

    }
}
