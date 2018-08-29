//
//  ControllerViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/29/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objc protocol ControllerViewModel {
    var didUpdate: (() -> Void) { get set }
    var numberOfRows: Int { get }
    var title: String { get }
    
    func loadDataIfNeeded(fromIndex index: Int)
    func viewModelForCell(at index: Int) -> GifCellViewModel
    func contentSize(at index: Int) -> CGSize
}
