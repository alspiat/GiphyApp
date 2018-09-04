//
//  GifListViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifTrendingViewModel: NSObject, GifListViewModel {
    
    private var gifEntities = [GifEntity]()
    
    var numberOfRows: Int {
        return gifEntities.count
    }
    
    var title: String = gifTrendingTitle
    
    var message: String = gifNoItemsMessage
    
    public var didUpdate: (() -> Void) = {}
    
    func loadDataIfNeeded(fromIndex index: Int) {
        
        let reloadIndex = 10;
        let dataLimit = 24;
        
        guard index == gifEntities.count - reloadIndex || gifEntities.isEmpty else {
            return
        }
        
        let api = APIService.shared
        
        api.fetchTrending(offset: gifEntities.count + 1, limit: dataLimit) { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    self.gifEntities.append(contentsOf: gifEntities)
                    self.message = gifNoItemsMessage
                    self.didUpdate()
                }
            case .Failure(let apiError):
                DispatchQueue.main.async {
                    self.message = gifNoConnectionMessage
                    self.didUpdate()
                }
            }
        }
    }
    
    func clearData() {
        self.gifEntities.removeAll()
    }
    
    func viewModelForCell(at index: Int) -> GifCellViewModel {
        return GifCellViewModel(gifEntity: gifEntities[index])
    }
    
    func contentSize(at index: Int) -> CGSize {
        let image = gifEntities[index].previewImage
        return CGSize(width: image.width, height: image.height)
    }
    
}
