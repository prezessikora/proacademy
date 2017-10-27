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
    
    var cardSnapshot: UIView!
    
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

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
            snapshot?.frame = finalFrame
            snapshot?.alpha = 1.0
            self.cardSnapshot.alpha = 0.0
            self.cardSnapshot.frame = finalFrame
        }, completion: { _ in
            toVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            self.cardSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
        
    }
}

