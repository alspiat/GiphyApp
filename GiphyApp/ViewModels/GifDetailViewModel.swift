//
//  GifDetailViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifDetailViewModel: NSObject {
    var gifEntity: GifEntity
    var gifData: Data?
    var gifImage: UIImage?
    
    var isAnimating: Bool = true
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
    public var didUpdate: (() -> Void) = {}
    
    public func loadGif() {
        DataManager.loadOriginalImageData(self.gifEntity, previewFirstly: true) { (data) in
            DispatchQueue.main.async {
                self.gifData = data
                if let data = self.gifData {
                    self.gifImage = UIImage.animatedImage(data: data)
                }
                self.didUpdate()
            }
        }
    }
    
    public func stopAnimating() {
        if let image = self.gifImage {
            self.gifImage = image.images?.first
            self.isAnimating = false
            self.didUpdate()
        }
    }
    
    public func startAnimating() {
        if let data = self.gifData {
            self.gifImage = UIImage.animatedImage(data: data)
            self.isAnimating = true
            self.didUpdate()
        }
    }
}
