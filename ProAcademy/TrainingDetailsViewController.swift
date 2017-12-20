//
//  TrainingDetailsViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 30/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

// formating of view values in one place
extension UIViewController {
    func formatPrice(of t: Training) -> String {
        return "\(t.price!) PLN"
    }
    
    func formatAvailablePlaces(of t: Training) -> String {
        return "\(t.remainingItems!)/\(t.offeredItems!)"
    }
    
    func priceButtonInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

class TrainingDetailsViewController: UIViewController {

    var training : Training?
    
    @IBOutlet weak var trainer: UILabel!
    @IBOutlet weak var trainingTitle: UILabel!
    
    @IBOutlet weak var availablePlaces: UILabel!
    @IBOutlet weak var price: UIButton!
    @IBOutlet weak var bookTrainingButton: UIButton!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fullDescription: UITextView!
    
    var myTrainingsService : MyTrainingsService {
        get {
            return Utils.application().myTrainings
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = training {
            self.title = t.title
            trainingTitle.text = t.title
            trainer.text = t.trainer
            availablePlaces.text = formatAvailablePlaces(of: t)
            price.setTitle(formatPrice(of: t), for: .normal)
            
            let htmlString = t.fullDescription            
            let htmlData = NSString(string: htmlString!).data(using: String.Encoding.unicode.rawValue)            
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
            fullDescription.attributedText = attributedString
        }
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        price.titleEdgeInsets = priceButtonInsets()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if myTrainingsService.haveBeenAlreadyBooked(training: training!) {
            bookTrainingButton.isEnabled = false
            bookTrainingButton.titleLabel?.text = "Szkolenie zarezerwowane"
        } else {
            bookTrainingButton.isEnabled = true
            bookTrainingButton.titleLabel?.text = "Zareerwuj"
        }
        fullDescription.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fullDescription.flashScrollIndicators()
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
