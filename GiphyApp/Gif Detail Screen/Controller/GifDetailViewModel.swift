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
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
    public var didUpdate: (() -> Void) = {}
    
    public func loadGif() {
        DataManager.loadOriginalImageData(self.gifEntity, previewFirstly: true) { (data) in
            DispatchQueue.main.async {
                self.gifData = data
                self.didUpdate()
            }
        }
    }
    
    
    
}
