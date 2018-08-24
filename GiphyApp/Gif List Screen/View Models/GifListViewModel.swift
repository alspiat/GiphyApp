//
//  GifListViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class GifListViewModel: NSObject {
    
    var gifEntities = [GifEntity](repeating: GifEntity(), count: 10)
    
    public var didUpdate: (() -> Void)?
    
    func viewModelForCell(at index: Int) -> GifCellViewModel {
        return GifCellViewModel(gifEntity: gifEntities[index])
    }
    
    func contentHeight(at index: Int) -> Float {
        return 100
    }
    
    func numberOfRows() -> Int {
        return gifEntities.count
    }
    
}
