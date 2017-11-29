//
//  FavouritesViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 03/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

protocol ReloadCallback {
    func reload()
}

class Tab {
    
    let button: UIButton
    let bar: UIView
    let container: UIView?
    var constraintLow: NSLayoutConstraint
    var constraintHigh: NSLayoutConstraint
    
    var reloadCallback: ReloadCallback?
    
    var active = false
    
    init(button: UIButton, bar: UIView, container: UIView? = nil) {
        self.button = button
        self.bar = bar
        self.container = container
        constraintLow = bar.heightAnchor.constraint(equalToConstant: 1)
        constraintHigh = bar.heightAnchor.constraint(equalToConstant: 2)
    }
    
    func activate() {
        self.button.setTitleColor(UIColor.black, for: .normal)
        self.bar.backgroundColor = UIColor.black
        
        if let c = container {
            c.isHidden = false
        }

        constraintLow.isActive = false
        constraintHigh.isActive = true
        
        if let contentToReload = reloadCallback {
            contentToReload.reload()
        }
        active = true
        
    }
    
    func deactivate() {
        self.button.setTitleColor(UIColor.gray, for: .normal)
        self.bar.backgroundColor = UIColor.gray
        
        if let c = container {
            c.isHidden = true
        }

        constraintHigh.isActive = false
        constraintLow.isActive = true
        
        active = false
        
    }

}

class TabBasedViewController : UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-Home-48"), style: .plain, target: nil , action: nil)
        self.navigationItem.titleView = UIImageView(image:  UIImage(named: "pa_title"))
    }
    
    func changeState(active: Tab, inactive: Tab...) {
        active.activate()
        
        for tab in inactive {
            tab.deactivate()
        }
    }
}

class FavouritesViewController: TabBasedViewController {

    var artistsTab: Tab!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var eventsBar: UIView!
    @IBOutlet weak var trainingsContainer: UIView!
    var artistsTabReloadCallback: ReloadCallback?
  
    var eventsTab: Tab!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var artistsBar: UIView!
    @IBOutlet weak var artistsContainer: UIView!
    var traningsReloadCallback: ReloadCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        eventsTab = Tab(button: eventsButton, bar: eventsBar, container: trainingsContainer)
        eventsTab.reloadCallback = traningsReloadCallback
        
        artistsTab = Tab(button: artistsButton, bar: artistsBar, container: artistsContainer)
        artistsTab.reloadCallback = artistsTabReloadCallback
        
        changeState(active: eventsTab, inactive: artistsTab)
    }

    @IBAction func onEvents(_ sender: Any) {
        changeState(active: eventsTab, inactive: artistsTab)
    }
    
    @IBAction func onArtists(_ sender: Any) {
        changeState(active: artistsTab, inactive: eventsTab)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "showFavouriteEvents" {
                let vc = segue.destination as! TrainingsCollectionViewController
                traningsReloadCallback = vc
            }
            if id == "showFavouriteArtists" {
                let vc = segue.destination as! ArtistsCollectionViewController
                artistsTabReloadCallback = vc
            }
        }
    }
}
