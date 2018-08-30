//
//  GifListViewModelTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifListViewModelTests: XCTestCase {
    var gifListViewModel:GifTrendingViewModel?
    
    override func setUp() {
        super.setUp()
        self.gifListViewModel = GifTrendingViewModel()
      
    }
    
    override func tearDown() {
      self.gifListViewModel = nil
        super.tearDown()
    }
    
    //load data if needed
    func test_loadDataIfNeeded_Success(){
        let index = 12
//        let arrayOfEntities:[GifEntity] = [GifEntity(JSON: )!]
        self.gifListViewModel?.loadDataIfNeeded(fromIndex: index)
        
    }
    
    func test_loadDataIfDontNeeded_Success() {
        
    }
    
    func test_viewModelForCell_Success() {
    }
    
    func test_contentSize_Success() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
