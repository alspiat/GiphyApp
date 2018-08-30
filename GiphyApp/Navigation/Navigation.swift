//
//  Navigation.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class Navigation: NSObject {

    static let shared = Navigation()
    
    public let navigationController: UINavigationController
    public let transitionManager:CircularControllerTransition
    private var currentCenterPoint: CGPoint
    
    private override init() {
        self.navigationController = UINavigationController()
        self.transitionManager = CircularControllerTransition()
        self.currentCenterPoint = CGPoint.zero

        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationController.navigationBar.titleTextAttributes = attributes
        self.navigationController.navigationBar.barTintColor = UIColor.black
        self.navigationController.navigationBar.isTranslucent = false
        
        super.init()
    }
    
    public func showTrendingGifs() {
        let viewModel = GifTrendingViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        gifListViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showFavouritesGifs() {
        let viewModel = GifFavouritesViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showSearchingGifs(query: String) {
        let viewModel = GifSearchViewModel(query: query)
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showGifDetail(with gifEntity: GifEntity ,and centerPoint:CGPoint) {
        self.currentCenterPoint = centerPoint
        self.transitionManager.startingPoint = self.currentCenterPoint
        
        let viewModel = GifDetailViewModel(gifEntity: gifEntity)
        let gifDetailViewController = GifDetailViewController(viewModel: viewModel)
        gifDetailViewController?.view.frame = UIScreen.main.bounds
        
        gifDetailViewController?.modalPresentationStyle = .custom
        gifDetailViewController?.transitioningDelegate = self;
        //        self.navigationController.present(gifDetailViewController!, animated: true, completion: nil)
        self.navigationController.viewControllers[0].present(gifDetailViewController!, animated: true, completion: nil)
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

