//
//  GifCellViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objc class GifCellViewModel: NSObject {
    @objc var gifEntity: GifEntity
    
    var didUpdate: (() -> Void)?
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
    }
}
