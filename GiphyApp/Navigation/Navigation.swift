//
//  Navigation.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class Navigation: NSObject {
    public let navigationController: UINavigationController
    public let transitionManager:CircularControllerTransition
    private var currentCenterPoint: CGPoint
    
    override init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.barTintColor = .black
        self.transitionManager = CircularControllerTransition()
        self.currentCenterPoint = CGPoint.zero
        super.init()
    }
    
    
    
    public func showGifList() {
        let viewModel = GifListViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    
/////////////////////////////////\\\\\Dimas\\\\\\\\\\///////////////////////////////////
    public func showGifDetail(with gifEntity: GifEntity ,and centerPoint:CGPoint, presentingController: UIViewController) {
        self.currentCenterPoint = centerPoint
        self.transitionManager.startingPoint = self.currentCenterPoint
        
        let viewModel = GifDetailViewModel(gifEntity: gifEntity)
        let gifDetailViewController = GifDetailViewController(viewModel: viewModel)
        gifDetailViewController?.view.frame = UIScreen.main.bounds
        
        gifDetailViewController?.modalPresentationStyle = .custom
        gifDetailViewController?.transitioningDelegate = self;
//        self.navigationController.present(gifDetailViewController!, animated: true, completion: nil)
        presentingController.present(gifDetailViewController!, animated: true, completion: nil)
        
    }
}


//MARK: ControllerTransitionDelegete
extension Navigation: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        self.transitionManager.transitionMode = .present
        self.transitionManager.startingPoint = self.currentCenterPoint
        self.transitionManager.circleColor = UIColor.black
        return self.transitionManager
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionManager.transitionMode = .dismiss
        self.transitionManager.startingPoint = self.currentCenterPoint
        self.transitionManager.circleColor = UIColor.black
        return self.transitionManager;
    }
}
/////////////////////////////////\\\\\Dimas\\\\\\\\\\///////////////////////////////////
