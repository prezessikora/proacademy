//
//  ArtistViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 06/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var artistDescription: UITextView!
    @IBOutlet weak var linkedButton: UIButton!
    
    var artistModel: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let a = artistModel {
            self.title = a.name
            self.imageView.image = a.image
            self.artistTitle.text = a.title
            self.artistDescription.text = a.description
            
        } else  { // else should not happen but detault to?
            self.title = "Natalia Stawiarska"
        }
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = navBarbutton
        
    }
    
    @objc
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        roundButton(ofButton: fbButton)
        roundButton(ofButton: linkedButton)
    }
    
    func roundButton(ofButton: UIButton) {
        ofButton.layer.masksToBounds = false
        ofButton.clipsToBounds = true
        ofButton.layer.cornerRadius = fbButton.frame.height/2
        ofButton.backgroundColor = UIColor.lightGray
        ofButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
