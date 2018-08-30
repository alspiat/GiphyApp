//
//  GifImage.swift
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifImage: NSObject, JSONDecodable, GifImageModel {
    
    var url: String
    var size: Int?
    var height: Int
    var width: Int
    
    required init?(JSON: JSON) {
        
        // Required values
        guard let url = JSON["url"] as? String,
            let heightStr = JSON["height"] as? String,
            let widthStr = JSON["width"] as? String,
            let height = Int(heightStr),
            let width = Int(widthStr) else {
                return nil
        }
        
        self.url = url
        self.width = width
        self.height = height
        
        // Optional values
        if let sizeStr = JSON["size"] as? String,
            let size = Int(sizeStr) {
            self.size = size
        }
    }
    
    init(with managedObject: GifImageModel) {
        self.url = managedObject.url
        self.height = managedObject.height
        self.width = managedObject.width
    }
}
