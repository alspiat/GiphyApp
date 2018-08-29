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
    var gifImage: UIImage?
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
    public var didUpdate: (() -> Void) = {}
    
    ///update
    public func loadGif() {
        DataManager.loadOriginalImageData(self.gifEntity) { (data) in
            DispatchQueue.main.async {
                self.gifImage = UIImage.animatedImage(data: data!)
                self.didUpdate()
            }
        }
    }
    
    
    
}
