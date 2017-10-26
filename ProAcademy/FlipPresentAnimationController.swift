//
//  class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {  FlipPresentAnimationController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 14/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceVC = transitionContext.viewController(forKey: .from)! as! UITabBarController
        let fromVC = sourceVC.selectedViewController as! ArtistsViewController
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let snapshot1 = fromVC.createCard(index: fromVC.currentCardIndex).snapshotView(afterScreenUpdates: true)
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        snapshot1?.frame = initialFrame
        
        // container has from view
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        containerView.addSubview(snapshot1!)
        
        snapshot1?.translatesAutoresizingMaskIntoConstraints = false

        
        snapshot1?.centerXAnchor.constraint(equalTo: (snapshot?.centerXAnchor)!).isActive = true
        snapshot1?.centerYAnchor.constraint(equalTo: (snapshot?.centerYAnchor)!).isActive = true
        
        snapshot1?.widthAnchor.constraint(equalTo: (snapshot?.widthAnchor)!).isActive = true
        snapshot1?.heightAnchor.constraint(equalTo: (snapshot?.heightAnchor)!).isActive = true
        
        toVC.view.isHidden = true
        fromVC.transitionCard?.alpha = 0.0
        
        let duration = transitionDuration(using: transitionContext)
        snapshot?.alpha = 0.0
        UIView.animate(withDuration: duration, animations: {
            snapshot?.frame = finalFrame
            snapshot?.alpha = 1.0
            snapshot1?.alpha = 0.0
            snapshot1?.frame = finalFrame

        }, completion: { _ in
            
            toVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            snapshot1?.removeFromSuperview()
            transitionContext.completeTransition(true)
            
        })
        
    }
}

