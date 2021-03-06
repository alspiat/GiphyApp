//
//  GifCellViewModelTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifCellViewModelTests: XCTestCase {
    var cellViewModel:GifCellViewModel?
    var gifEntity: GifEntity?
    var loadingTask: NetworkCancelable?
    
    override func setUp() {
        super.setUp()
        let json:JSON = [
            "id": "feqkVgjJpYtjy",
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
            ]
        self.gifEntity = GifEntity(JSON: json)
        
        if let gif = self.gifEntity {
            self.cellViewModel = GifCellViewModel(gifEntity: gif)
        }
        
    }
    
    override func tearDown() {
        self.gifEntity = nil
        self.cellViewModel = nil
        super.tearDown()
    }
    
    func test_GifCellViewModel_initWithGif_Success() {
        let json:JSON = [
            "id": "feqkVgjJpYtjy",
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
            ]
        guard let gif = GifEntity(JSON: json) else {return XCTFail("test_GifCellViewModel_initWithGif_Success FAILURE")}
        
        let cell = GifCellViewModel(gifEntity: gif)
        XCTAssertTrue(cell.gifEntity == gif)
    }
    
    
    func test_startImageDownloading_Success() {
        var image: UIImage?
        guard let cell = self.cellViewModel else {return XCTFail("test_startImageDownloading_Success FAILURE with cellViewModel")}
        
        cell.startImageLoading()
        self.performBlockAfterDelay(block: {
             XCTAssertTrue(image != nil)
        }, delay: 10)
    }
    
    
    
    func test_cancel_imageDownloading_Success() {
        var image: UIImage?
        guard let cell = self.cellViewModel else {return XCTFail("test_startImageDownloading_Success FAILURE with cellViewModel")}
        //start
        cell.startImageLoading()

        //cancel
        cell.cancelImageLoading()
        image = cell.image
        XCTAssertTrue(image == nil)
    }
    
    
    //helper Functions
   @objc func  performBlock(block: ()->()) {
        block()
    }
    
    func performBlockAfterDelay(block: ()->(), delay: TimeInterval) {
        self.perform(#selector(performBlock(block:)), with: block, afterDelay: delay)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
