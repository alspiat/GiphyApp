//
//  GifCellViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifCellViewModel: NSObject {
    
    private var loadingDataTask: URLSessionDataTask?
    
    var gifEntity: GifEntity
    var image: UIImage?
    
    var didUpdate: (() -> Void) = {}
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
    func cancelImageLoading() {
        if let loadingDataTask = self.loadingDataTask {
            loadingDataTask.cancel()
        }
    }
    
    func startImageLoading() {
        let api = APIService.shared
        
        self.loadingDataTask = api.fetchImage(stringURL: gifEntity.previewImage.url) { (image) in
            DispatchQueue.main.async {
                self.image = image
                self.didUpdate()
            }
        }
    }
}
