//
//  GifCoreDataViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class GifFavouritesViewModel: NSObject, GifListViewModel {
    
    private var gifEntities = [GifEntity]()
    
    var numberOfRows: Int {
        return gifEntities.count
    }
    
    var title: String {
        return "Favourites"
    }
    
    public var didUpdate: (() -> Void) = {}
    
    func loadDataIfNeeded(fromIndex index: Int) {
        
        let coreDataServive = CoreDataManager()
        self.gifEntities = coreDataServive.getAllItems()
        self.didUpdate()
    }
    
    func viewModelForCell(at index: Int) -> GifCellViewModel {
        return GifCellViewModel(gifEntity: gifEntities[index])
    }
    
    func contentSize(at index: Int) -> CGSize {
        let image = gifEntities[index].previewImage
        return CGSize(width: image.width, height: image.height)
    }
    
}
