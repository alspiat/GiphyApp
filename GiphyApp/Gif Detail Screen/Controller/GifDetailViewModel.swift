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
        DataManager.loadOriginalImage(self.gifEntity) { (image) in
            DispatchQueue.main.async {
                self.gifImage = image
                self.didUpdate()
            }
        }
    }
    
    
    
}
