//
//  TrainingDetailsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class TrainingDetailsViewController: UIViewController {

    var training : Training?
    
    @IBOutlet weak var trainer: UILabel!
    @IBOutlet weak var trainingTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = training?.title
        trainingTitle.text = training?.title
        trainer.text = training?.trainer
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookingView" {
            let bookingVC = segue.destination as! BookingViewController
            bookingVC.training = training
        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {

    }
    
}
