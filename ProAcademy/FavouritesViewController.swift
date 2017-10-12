//
//  FavouritesViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 03/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class Tab {
    
    let button: UIButton
    let bar: UIView
    let container: UIView
    var constraintLow: NSLayoutConstraint
    var constraintHigh: NSLayoutConstraint
    
    init(button: UIButton, bar: UIView, container: UIView) {
        self.button = button
        self.bar = bar
        self.container = container
        constraintLow = bar.heightAnchor.constraint(equalToConstant: 1)
        constraintHigh = bar.heightAnchor.constraint(equalToConstant: 2)
    }
    
    func activate() {
        self.button.setTitleColor(UIColor.black, for: .normal)
        self.bar.backgroundColor = UIColor.black
        self.container.isHidden = false

        constraintLow.isActive = false
        constraintHigh.isActive = true
        
    }
    
    func deactivate() {
        self.button.setTitleColor(UIColor.gray, for: .normal)
        self.bar.backgroundColor = UIColor.gray
        self.container.isHidden = true

        constraintHigh.isActive = false
        constraintLow.isActive = true
        
    }

}

class FavouritesViewController: UIViewController {

    var artistsTab: Tab!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var eventsBar: UIView!
    @IBOutlet weak var trainingsContainer: UIView!
  
    var eventsTab: Tab!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var artistsBar: UIView!
    @IBOutlet weak var artistsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        eventsTab = Tab(button: eventsButton, bar: eventsBar, container: trainingsContainer)
        artistsTab = Tab(button: artistsButton, bar: artistsBar, container: artistsContainer)
        
        changeState(active: eventsTab, inactive: artistsTab)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-Home-48"), style: .plain, target: nil , action: nil)
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Utils.imageFrom(systemItem: .search), style: .plain, target: nil , action: nil)
        
        self.navigationItem.titleView = UIImageView(image:  UIImage(named: "pa_title"))
        
    }
    
    func changeState(active: Tab, inactive: Tab) {
        active.activate()
        inactive.deactivate()
    }
    
    @IBAction func onEvents(_ sender: Any) {
        changeState(active: eventsTab, inactive: artistsTab)
    }
    
    @IBAction func onArtists(_ sender: Any) {
        changeState(active: artistsTab, inactive: eventsTab)
    }
    
}
