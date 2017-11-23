//
//  WelcomeContainerViewController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 29/09/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit
import Auth0
import Lock

extension UIAlertController {
    
    static func loadingAlert() -> UIAlertController {
        return UIAlertController(title: "Loading", message: "Please, wait...", preferredStyle: .alert)
    }
    
    func presentInViewController(_ viewController: UIViewController) {
        viewController.present(self, animated: true, completion: nil)
    }
    
}


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
    @IBAction func onBegin(_ sender: Any) {
        checkToken()
    }
    
    fileprivate func checkToken() {
        let loadingAlert = UIAlertController.loadingAlert()
        loadingAlert.presentInViewController(self)
        
        SessionManager.shared.renewAuth { error in
            DispatchQueue.main.async {
                loadingAlert.dismiss(animated: true) {
                    guard error == nil else {
                        print("Failed to retrieve credentials: \(String(describing: error))")
                        return self.login()
                    }
                    SessionManager.shared.retrieveProfile { error in
                        DispatchQueue.main.async {
                            guard error == nil else {
                                print("Failed to retrieve profile: \(String(describing: error))")
                                return self.login()
                            }
                            self.performSegue(withIdentifier: "showMainView", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    fileprivate func login() {
        Lock
            .classic()
            .withOptions {
                $0.oidcConformant = true
                $0.scope = "openid profile offline_access"
                $0.closable = true
            }.withStyle { (style: inout Style) -> Void in
                style.hideTitle = true
                style.headerColor = UIColor(red: 241, green: 241, blue: 241)
                style.logo = LazyImage(name: "login logo")
                style.primaryColor = UIColor.black
            }
            .onAuth { credentials in
                print("Access token : \(credentials.accessToken)")
                
                if(!SessionManager.shared.store(credentials: credentials)) {
                    print("Failed to store credentials")
                } else {
                    SessionManager.shared.retrieveProfile { error in
                        DispatchQueue.main.async {
                            guard error == nil else {
                                print("Failed to retrieve profile: \(String(describing: error))")
                                return self.login()
                            }
                            self.performSegue(withIdentifier: "showMainView", sender: self)
                        }
                    }
                }
                
            }.onError(callback: { error in
                print(error.localizedDescription)
            })
            .present(from: self)
        
        
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

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
