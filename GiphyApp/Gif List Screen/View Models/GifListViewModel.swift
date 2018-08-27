//
//  GifListViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifListViewModel: NSObject {
    
    var gifEntities = [GifEntity]()
    
    public var didUpdate: (() -> Void) = {}
    
    override init() {
        super.init()
        
        let api = APIService.shared
        
        api.fetchTrending { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    self.gifEntities = gifEntities
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
        return CGSize(width: gifEntities[index].originImage!.width, height: gifEntities[index].originImage!.height)
    }
    
    func numberOfRows() -> Int {
        return gifEntities.count
    }
    
}
