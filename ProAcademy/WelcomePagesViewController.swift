//
//  WelcomeViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 29/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class WelcomePagesViewController: UIPageViewController {

    weak var welcomeDelegate: WelcomePageViewControllerDelegate?
    
    lazy var orderedViewControllers: [UIViewController] = {
       return [self.newPageViewController(name: "welcomePage1"),
               self.newPageViewController(name: "welcomePage2"),
               self.newPageViewController(name: "welcomePage3")]
    }()
    
    func newPageViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        welcomeDelegate?.welcomePageViewController(welcomePageViewController: self,didUpdatePageCount: orderedViewControllers.count)
    }

}


extension WelcomePagesViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            welcomeDelegate?.welcomePageViewController(welcomePageViewController: self,didUpdatePageIndex: index)
        }
    }
}

protocol WelcomePageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func welcomePageViewController(welcomePageViewController: WelcomePagesViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func welcomePageViewController(welcomePageViewController: WelcomePagesViewController,
                                    didUpdatePageIndex index: Int)
    
}

extension WelcomePagesViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        guard nextIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
        
    }
}
