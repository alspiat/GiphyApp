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
    
    //show TrendingGifs
    public func showTrendingGifs() {
        let viewModel = GifTrendingViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        gifListViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem()
        gifListViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    //show FavouritesGifs CoreData
    public func showFavouritesGifs() {
        let viewModel = GifFavouritesViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    //show SearchingGifs with query
    public func showSearchingGifs(query: String) {
        let viewModel = GifSearchViewModel(query: query)
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    //show GifDetailController
    public func showGifDetail(with gifEntity: GifEntity ,and centerPoint:CGPoint) {
        self.currentCenterPoint = centerPoint
        self.transitionManager.startingPoint = self.currentCenterPoint
        
        let viewModel = GifDetailViewModel(gifEntity: gifEntity)
        let gifDetailViewController = GifDetailViewController(viewModel: viewModel)
        gifDetailViewController?.view.frame = UIScreen.main.bounds
        
        gifDetailViewController?.modalPresentationStyle = .custom
        gifDetailViewController?.transitioningDelegate = self;
        self.navigationController.viewControllers.last?.present(gifDetailViewController!, animated: true, completion: nil)
    }
    
    
    //showSettingsController
    public func showSettingsController() {
        let controller = SettingsPopUpController()
        controller.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(controller, animated: true, completion: nil)
        
    }
    
    public func reloadControllerList() {
        if let controller = self.navigationController.viewControllers.last as? GifListViewController {
            controller.reloadList()
        }
    }
}


//MARK: ControllerTransitionDelegete
extension Navigation: UIViewControllerTransitioningDelegate {
    
    //for presenting
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        self.transitionManager.transitionMode = .present
        self.transitionManager.startingPoint = self.currentCenterPoint
        self.transitionManager.circleColor = UIColor.black
        return self.transitionManager
    }
    
    //for dimsissing
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionManager.transitionMode = .dismiss
        self.transitionManager.startingPoint = self.currentCenterPoint
        self.transitionManager.circleColor = UIColor.black
        return self.transitionManager;
    }
}

