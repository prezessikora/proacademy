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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let welcomePageViewController = segue.destination as? WelcomePageViewController {
            welcomePageViewController.welcomeDelegate = self
        }

    }
}

extension WelcomeViewController: WelcomePageViewControllerDelegate {
    
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
