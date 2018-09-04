//
//  GifSearchViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/29/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class GifSearchViewModel: NSObject, GifListViewModel {
    var message: String = gifNoItemsMessage
    
    private var gifEntities = [GifEntity]()
    private var query: String
    
    var numberOfRows: Int {
        return gifEntities.count
    }
    
    var title: String {
        return query
    }
    
    public var didUpdate: (() -> Void) = {}
    
    init(query: String) {
        self.query = query
        super.init()
    }
    
    func loadDataIfNeeded(fromIndex index: Int) {
        
        let reloadIndex = 10;
        let dataLimit = 24;
        
        guard index == gifEntities.count - reloadIndex || gifEntities.isEmpty else {
            return
        }
        
        let api = APIService.shared
        
        var ratingType = GifRatingType.unrated
        if let rating = UserDefaults.standard.string(forKey: SettingsViewModel.kSettingsRatingPicker()) {
            ratingType = GifRatingType(rawValue: rating)!
        }
        
        api.fetchSearch(query: query, offset: gifEntities.count, limit: dataLimit, rating: ratingType) { (result) in
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
