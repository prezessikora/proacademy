//
//  FadeDismissAnimationController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 26/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class FadeDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var destinationFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        let toVC = transitionContext.viewController(forKey: .to)! as! UITabBarController
        let artistsVC = toVC.selectedViewController as! ArtistsViewController
        
        let initialFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = destinationFrame
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        let cardSnapshot = artistsVC.currentCardSnapShot()

        cardSnapshot.frame = initialFrame

        let containerView = transitionContext.containerView
        
        containerView.addSubview(snapshot!)
        containerView.addSubview(cardSnapshot)

        // align card carousel with details VC
        cardSnapshot.translatesAutoresizingMaskIntoConstraints = false
        cardSnapshot.centerXAnchor.constraint(equalTo: (snapshot?.centerXAnchor)!).isActive = true
        cardSnapshot.centerYAnchor.constraint(equalTo: (snapshot?.centerYAnchor)!).isActive = true
        cardSnapshot.widthAnchor.constraint(equalTo: (snapshot?.widthAnchor)!).isActive = true
        cardSnapshot.heightAnchor.constraint(equalTo: (snapshot?.heightAnchor)!).isActive = true
        cardSnapshot.alpha = 0.0
        
        fromVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            snapshot?.frame = finalFrame
            snapshot?.alpha = 0.0
            
            cardSnapshot.frame = finalFrame
            cardSnapshot.alpha = 1.0
            
        }, completion: { _ in
            
            snapshot?.removeFromSuperview()
            cardSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
            
            artistsVC.carousel.isHidden = false
            artistsVC.setTabBarVisible(visible: true, animated: true) { _ in }
        })
    }
    
}
