//
//  class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {  FlipPresentAnimationController.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 14/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransformForContainerView(_ containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let avc = (fromVC as! UITabBarController).selectedViewController as! ArtistsViewController
        
        let containerView = transitionContext.containerView
        
        
        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        snapshot?.layer.transform = AnimationHelper.yRotation(Double.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                    fromVC.view.layer.transform = AnimationHelper.yRotation(-Double.pi / 2)
                })

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    snapshot?.layer.transform = AnimationHelper.yRotation(0.0)
                })

                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    snapshot?.frame = finalFrame
                })
        },
            completion: { _ in
                // 5
                toVC.view.isHidden = false
                fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

