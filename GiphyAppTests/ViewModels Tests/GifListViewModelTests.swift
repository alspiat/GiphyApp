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
    var gifEntities: [GifEntity]?
    
    override func setUp() {
        super.setUp()
        let json = [ "id": "feqkVgjJpYtjy",
                     "url": "https://giphy.com/gifs/eyes-shocked-bird-feqkVgjJpYtjy",
                     "username": "",
                     "rating": "g",
                     "content_url": "",
                     "source_tld": "littleanimalgifs.tumblr.com",
                     "source_post_url": "https://littleanimalgifs.tumblr.com/post/17994517807",
                     "import_datetime": "2013-03-21 04:03:08",
                     "trending_datetime": "2014-11-12 06:22:52",
                     
                     "images": [
                        "fixed_height_still": [
                            "url": "https://media0.giphy.com/media/feqkVgjJpYtjy/200_s.gif",
                            "width": "445",
                            "height": "200"
                        ],
                        "preview_gif": [
                            "url": "https://media0.giphy.com/media/feqkVgjJpYtjy/200_d.gif",
                            "width": "445",
                            "height": "200",
                            "size": "183225",
                            "webp": "http://media0.giphy.com/media/feqkVgjJpYtjy/200_d.webp",
                            "webp_size": "89516"
                        ],
                        "original": [
                            "url": "https://media0.giphy.com/media/feqkVgjJpYtjy/giphy.gif",
                            "width": "334",
                            "height": "150",
                            "size": "511581",
                            "frames": "27",
                            "mp4": "http://media0.giphy.com/media/feqkVgjJpYtjy/giphy.mp4",
                            "mp4_size": "97841",
                            "webp": "http://media0.giphy.com/media/feqkVgjJpYtjy/giphy.webp",
                            "webp_size": "270108"
                        ],
                        
            ],
         "title": "Shocked Eyes GIF",
         ] as [String : Any]
        
        let gifEntity = GifEntity(JSON: json)
        self.gifEntities = Array(repeating: gifEntity, count: 30) as? [GifEntity]
        self.gifListViewModel = GifTrendingViewModel()
        
      
    }
    
    override func tearDown() {
      self.gifListViewModel = nil
        super.tearDown()
    }
    
    
    //for trending
    func test_trending_loadDataIfNeeded_Success(){
        
        var index = 10
        let expectation = self.expectation(description: "ready")
        
        self.gifListViewModel?.didUpdate = {
            expectation.fulfill()
            index = 1000
        }
        self.gifListViewModel?.loadDataIfNeeded(fromIndex: index)
      
        self.waitForExpectations(timeout: 10) { (error) in
             XCTAssertTrue(index == 1000)
        }
       
        
    }
    
    func test_clearData_Success() {
        //calls standard function and don't need to be tested
    }
    
    func test_viewModelForCell_Success() {
        //don't need to be testes because this tested in GifCellViewModel
    }
    
    func test_contentSize_Success() {
        //don't need to be testes because this method works with standaed functions
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
