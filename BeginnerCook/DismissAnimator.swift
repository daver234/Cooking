//
//  DismissAnimator.swift
//  BeginnerCook
//
//  Created by David Rothschild on 5/5/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 1 setup the transition
        let containerView = transitionContext.containerView()!
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // this code creates an empty view as big as the transition containerView and
        // sets its background to an almost fully opaque black color. Then add the dark view
        // to the transition constainerView just under fromView
        let background = UIView(frame: containerView.bounds)
        background.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        containerView.insertSubview(background, belowSubview: fromView)
        
       
        
        // 2. animations
        UIView.animateWithDuration(duration/2, delay: 0.0,
            usingSpringWithDamping: 0.5, initialSpringVelocity: 0,
            options: [], animations: {
            
            fromView.transform = CGAffineTransformMakeScale(0.5, 0.5)
            
            }, completion: nil)
        
        UIView.animateWithDuration(duration/2, delay: duration/2, options: [], animations: {
            
            fromView.center.x += containerView.frame.size.width
            
        }, completion: {_ in
            
            // 3. complete the transition
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
     
        UIView.animateWithDuration(duration, delay: 0.0, options: [], animations: {
            background.alpha = 0 }, completion: {_ in
                // remove from view hierarchy
                background.removeFromSuperview()
        })
    }
}
