//
//  GifCellViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifCellViewModel: NSObject {
    
    private var loadingTask: NetworkCancelable?
    
    var gifEntity: GifEntity
    var image: UIImage?
    
    var didUpdate: (() -> Void) = {}
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
    func cancelImageLoading() {
        if let loadingTask = self.loadingTask {
            loadingTask.cancel()
        }
    }
    
    func startImageLoading() {
        self.loadingTask = DataManager.loadPreviewImageData(gifEntity) { (data) in
            DispatchQueue.main.async {
                self.image = UIImage.animatedImage(data: data!)
                self.didUpdate()
            }
        }
    }
}
