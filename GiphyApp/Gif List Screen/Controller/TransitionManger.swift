//
//  TransitionManger.swift
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 28/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objc class CircularControllerTransition: NSObject {
    var circle = UIView()
    @objc var startingPoint = CGPoint.zero {
        didSet {circle.center = startingPoint}
    }
    @objc  var circleColor = UIColor.white
    var duration = 0.3
    
    //transitions enum
    @objc enum CircularTransitionMode:Int {
        case present
        case dismiss
        case pop        //for navigation vc
    }
    
    @objc var transitionMode: CircularTransitionMode = .present
}



//MARK: - UIViewControllerAnimatedTransitioning protocol
extension CircularControllerTransition: UIViewControllerAnimatedTransitioning {
    
    //transition duration
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    //animation code here
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            // to -- view shown at the end of completed transition
            if let  presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                self.circle = UIView()
                //set the circle calculated frame
                self.circle.frame = self.frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint:startingPoint)
                self.circle.layer.cornerRadius = circle.frame.size.width / 2
                self.circle.center = self.startingPoint
                self.circle.backgroundColor = self.circleColor
                
                //transform the circle and shrinking it down
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                //add cicrcle as as subview to containerView
                containerView.addSubview(self.circle)
                
                //configuring presentedView
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                //start animating
                UIView.animate(withDuration: self.duration, animations: {
                    self.circle.transform = CGAffineTransform.identity //transforms to original form and size
                    presentedView.transform = CGAffineTransform.identity
                    print("presented view frame: \(presentedView.frame)")
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }) { (success:Bool) in
                    //complete transition
                    transitionContext.completeTransition(success)
                }
            }
            
        } else {
            
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            //create returning view
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                //calculate frame for circle
                self.circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: self.startingPoint)
                self.circle.layer.cornerRadius = self.circle.frame.size.width / 2
                self.circle.center = self.startingPoint
                
                //animate
                UIView.animate(withDuration: self.duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                }, completion: { (success:Bool) in
                    
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    
    
    //calculate Frame for circle
    func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width  - startPoint.x)  //returns bigger one
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        //calculate offset vector
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}
