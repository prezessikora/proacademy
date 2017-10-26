//
//  ArtistViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var companyTitle: UILabel!
    
    @IBOutlet weak var fbButton: UIButton!
    
    @IBOutlet weak var info: UITextView!
    
    @IBOutlet weak var linkedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "Natalia Stawiarska"
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = navBarbutton
        
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
 

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        configureButton(button: fbButton)
        configureButton(button: linkedButton)

    }
    
    func configureButton(button: UIButton) {
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.cornerRadius = fbButton.frame.height/2
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
