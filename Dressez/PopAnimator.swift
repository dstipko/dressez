//
//  PopAnimator.swift
//  Dressez
//
//  Created by Dora Stipković on 5/2/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.3
    var presenting = true
    var originFrame = CGRect.zero
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = presenting ? toView :
            transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : fromView.frame
        let finalFrame = presenting ? fromView.frame : originFrame
        
        let xScaleFactor = presenting ?
            
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                               y: yScaleFactor)
        
        if presenting {
            fromView.transform = scaleTransform
            fromView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            fromView.clipsToBounds = true
        }
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: fromView)
        
        UIView.animate(withDuration: duration, delay: 0.0,
                       animations: {
                        fromView.transform = self.presenting ?
                            CGAffineTransform.identity : scaleTransform
                        fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                       }, completion: {_ in
                        transitionContext.completeTransition(true)
                       })
    }
    
}
