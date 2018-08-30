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
    var isSaved: Bool = false
    
    init(gifEntity: GifEntity) {
        self.gifEntity = gifEntity
        
        let coreDataManager = CoreDataManager()
        if coreDataManager.itemExists(withID: self.gifEntity.id) {
            self.isSaved = true
        }
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
    
    public func saveToPersistance() -> Bool {
        let coreDataManager = CoreDataManager()
        let fileManager = AppFileManager()
        
        if let data = self.gifData {
            let filename = "\(self.gifEntity.id).gif"
            fileManager.createFile(filename, data: data, folder: AppFileManager.originalsPath)
            coreDataManager.addItem(self.gifEntity)
            self.isSaved = true
            return true
        } else {
            return false
        }
    }
    
    public func removeFromPersistance() -> Bool {
        let coreDataManager = CoreDataManager()
        let fileManager = AppFileManager()
        
        let filename = "\(self.gifEntity.id).gif"
        let result = fileManager.removeFile(filename, folder: AppFileManager.originalsPath)
        
        if result {
            coreDataManager.deleteItem(self.gifEntity)
            self.isSaved = false
            return true
        } else {
            return false
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
