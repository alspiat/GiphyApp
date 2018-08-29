//
//  GifSearchViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/29/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class GifSearchViewModel: NSObject, ControllerViewModel {
    
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
        
        api.fetchSearch(query: query, limit: dataLimit) { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    self.gifEntities.append(contentsOf: gifEntities)
                    self.didUpdate()
                }
            case .Failure(let apiError):
                print(apiError.description)
            }
        }
    }
    
    func viewModelForCell(at index: Int) -> GifCellViewModel {
        return GifCellViewModel(gifEntity: gifEntities[index])
    }
    
    func contentSize(at index: Int) -> CGSize {
        let image = gifEntities[index].previewImage
        return CGSize(width: image!.width, height: image!.height)
    }
    
}
