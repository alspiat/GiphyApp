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
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
    
}
