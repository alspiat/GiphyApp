//
//  GifImage.swift
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifImage: NSObject {
    var url: String = ""
    var size: Int = 0
    var height: Int = 0
    var width: Int = 0
    
    init?(JSON: JSON) {
        guard let url = JSON["url"] as? String,
            let heightStr = JSON["height"] as? String,
            let widthStr = JSON["width"] as? String,
            let sizeStr = JSON["size"] as? String else {
                return nil
        }
        
        
        self.url = url
        
        if let size = Int(sizeStr),
            let height = Int(heightStr),
            let width = Int(widthStr) {
            
            self.size = size
            self.width = width
            self.height = height
        }
    }
}
