//
//  Navigation.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

class Navigation: NSObject {
    public let navigationController: UINavigationController
    
    override init() {
        self.navigationController = UINavigationController()
        super.init()
    }
    
    public func showGifList() {
        let viewModel = GifListViewModel()
        let gifListViewController = GifListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifListViewController!, animated: true)
    }
    
    public func showGifDetail() {
        let viewModel = GifDetailViewModel()
        let gifDetailViewController = GifDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(gifDetailViewController!, animated: true)
    }
}
