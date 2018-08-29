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
    
    private override init() {
        self.navigationController = UINavigationController()
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationController.navigationBar.titleTextAttributes = attributes
        self.navigationController.navigationBar.barTintColor = UIColor.black
        self.navigationController.navigationBar.isTranslucent = false
        
        super.init()
    }
    
    public func showGifList() {
        let viewModel = GifListViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showGifSearch(query: String) {
        let viewModel = GifSearchViewModel(query: query)
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showGifDetail() {
        let viewModel = GifDetailViewModel()
        let gifDetailViewController = GifDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifDetailViewController!, animated: true)
    }
}
