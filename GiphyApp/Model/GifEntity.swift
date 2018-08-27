//
//  GifEntity.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class GifEntity: NSObject {
    var id: String = ""
    var title: String = ""
    var username: String = ""
    var rating: GifRatingType = .unrated
    var originImage: GifImage?
    var previewImage: GifImage?
    
    init?(JSON: JSON) {
        guard let id = JSON["id"] as? String,
            let title = JSON["title"] as? String,
            let username = JSON["username"] as? String,
            let rating = JSON["rating"] as? String else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.username = username
        if let ratingType = GifRatingType(rawValue: rating) {
            self.rating = ratingType
        }
        
        if let imagesData = JSON["images"] as? JSON,
            let originalImageData = imagesData["original"] as? JSON,
            let originalImage = GifImage(JSON: originalImageData) {
            self.originImage = originalImage
        }
    }
}
