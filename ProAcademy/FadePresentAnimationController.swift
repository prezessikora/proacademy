//
//  class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {  FlipPresentAnimationController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 14/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class FadePresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewController(forKey: .from)! as! UITabBarController
        let artistsVC = fromVC.selectedViewController as! ArtistsViewController
        let toVC = transitionContext.viewController(forKey: .to)!
        
        artistsVC.carousel.isHidden = false

        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let cardSnapshot = artistsVC.currentCardSnapShot()
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        cardSnapshot.frame = initialFrame
        
        // container has from view
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.white
        containerView.addSubview(toVC.view)
        toVC.view.isHidden = true
        
        containerView.addSubview(snapshot!)
        snapshot?.alpha = 0.0
        
        containerView.addSubview(cardSnapshot)
        cardSnapshot.translatesAutoresizingMaskIntoConstraints = false
        cardSnapshot.centerXAnchor.constraint(equalTo: (snapshot?.centerXAnchor)!).isActive = true
        cardSnapshot.centerYAnchor.constraint(equalTo: (snapshot?.centerYAnchor)!).isActive = true
        cardSnapshot.widthAnchor.constraint(equalTo: (snapshot?.widthAnchor)!).isActive = true
        cardSnapshot.heightAnchor.constraint(equalTo: (snapshot?.heightAnchor)!).isActive = true
        
        artistsVC.transitionCard?.removeFromSuperview()
        
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
            snapshot?.frame = finalFrame
            snapshot?.alpha = 1.0
            cardSnapshot.alpha = 0.0
            cardSnapshot.frame = finalFrame
        }, completion: { _ in
            toVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            cardSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
        
    }
}

