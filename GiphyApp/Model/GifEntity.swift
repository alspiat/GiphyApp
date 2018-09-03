//
//  GifEntity.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class GifEntity: NSObject, JSONDecodable, GifModel {
    
    var id: String
    var title: String?
    var username: String?
    var publishingDate: Date?
    var trendingDate: Date?
    var rating: GifRatingType = .unrated
    var originalImage: GifImageModel
    var previewImage: GifImageModel
    
    required init?(JSON: JSON) {
        
        // Required values
        guard let id = JSON[gifIdField] as? String,
            let imagesData = JSON[gifImagesField] as? JSON,
            let originalImageData = imagesData[gifOriginalField] as? JSON,
            let previewImageData = imagesData[gifPreviewField] as? JSON,
            let originalImage = GifImage(JSON: originalImageData),
            let previewImage = GifImage(JSON: previewImageData) else {
                return nil
        }
        
        self.id = id
        self.originalImage = originalImage
        self.previewImage = previewImage
        
        // Optional values
        if let title = JSON[gifTitleField] as? String {
            self.title = title
        }
        
        if let username = JSON[gifUsernameField] as? String {
            self.username = username
        }
        
        if let rating = JSON[gifRatingField] as? String,
            let ratingType = GifRatingType(rawValue: rating) {
            self.rating = ratingType
        }
        
        if let publishingDateStr = JSON[gifPubDateField] as? String,
            let publishingDate = Date.date(string: publishingDateStr) {
            self.publishingDate = publishingDate
        }
        
        if let trendingDateStr = JSON[gifTrendDateField] as? String,
            let trendingDate = Date.date(string: trendingDateStr) {
            self.trendingDate = trendingDate
        }
        
    }
    
    //MARK: - MamagedObjectInit
    init?(with managedObject: GifManagedObjectEntity) {
        guard let titleMO       = managedObject.title,
            let usernameMO       = managedObject.username,
            let publishingDateMO = managedObject.publishingDate,
            let trendingDateMO   = managedObject.trendingDate else {
            return nil
            
        }
        
        self.id = managedObject.id
        self.title = titleMO
        self.username = usernameMO
        self.publishingDate = publishingDateMO
        self.trendingDate = trendingDateMO
        self.originalImage = GifImage(with: managedObject.originalImage)
        self.previewImage = GifImage(with: managedObject.previewImage)
    }
}
