//
//  WelcomeContainerViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 29/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var beginButton: UIButton!
    
    // It is hidden in Info.plist by default for launch screen
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        // this is to have nice tutorial images trainsition
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 5.0
        
        beginButton.backgroundColor = UIColor.black
        beginButton.setTitleColor(.white, for: .normal)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let welcomePageViewController = segue.destination as? WelcomePagesViewController {
            welcomePageViewController.welcomeDelegate = self
        }

    }
}

extension WelcomeViewController: WelcomePageViewControllerDelegate {
    
    func welcomePageViewController(welcomePageViewController: WelcomePagesViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func welcomePageViewController(welcomePageViewController: WelcomePagesViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
