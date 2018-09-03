//
//  GifDetailViewModelTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifDetailViewModelTests: XCTestCase {
    var gifDetailViewModel: GifDetailViewModel?
    var gifEntity: GifEntity?
    var gifData: Data?
    var gifImage: UIImage?
    
    var isAnimating: Bool = true
    var isSaved: Bool = false
    
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
        
        guard let gif = GifEntity(JSON: json) else {return}
        self.gifEntity = gif
        self.gifDetailViewModel = GifDetailViewModel(gifEntity: gif)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_initWithGifEntity_Success() {
        guard let gif = self.gifEntity else {return XCTFail("test_initWithGifEntity_Success ")}
        let detailViewModel = GifDetailViewModel(gifEntity: gif)
      XCTAssert(detailViewModel.gifEntity == gif)
    }
    
    func test_loadGif_Success() {
        //intrinsic methods was tested previously
        let data = self.gifDetailViewModel?.gifData
        self.gifDetailViewModel?.loadGif()
        self.performBlockAfterDelay(block: {
             XCTAssertTrue(data != nil)
        }, delay: 10)
    }
    
    func test_cancelImageLoading_Success() {
       //intrinsic methods was tested previously
    }
    
    func test_saveToPersistance_Success() {
        let data = Data()
        self.gifDetailViewModel?.gifData = data
        let result = self.gifDetailViewModel?.saveToPersistance()
        XCTAssertTrue(result == true)
        self.gifDetailViewModel?.removeFromPersistance()
    }
    
    func test_saveToPersistance_Failure() {
        let result = self.gifDetailViewModel?.saveToPersistance()
        XCTAssertTrue(result == false)
    self.gifDetailViewModel?.removeFromPersistance()
    }
    
    func test_removeFromPersistance_Success() {
        let data = Data()
        self.gifDetailViewModel?.gifData = data
        self.gifDetailViewModel?.saveToPersistance()
        let result = self.gifDetailViewModel?.removeFromPersistance()
        XCTAssertTrue(result == true)
    }
    
    func test_removeFromPersistance_Failure() {
        self.gifDetailViewModel?.saveToPersistance()
        let result = self.gifDetailViewModel?.removeFromPersistance()
        XCTAssertTrue(result == false)
    }
    
    func test_stopAnimating_Success() {
        let image = UIImage()
        self.gifDetailViewModel?.gifImage = image
        self.gifDetailViewModel?.stopAnimating()
        
        self.gifDetailViewModel?.didUpdate = {
            XCTAssertTrue(true)
        }
    }
    
    func test_startAnimating_Success() {
        let data = Data()
        let image = UIImage()
        self.gifDetailViewModel?.gifData = data
        self.gifDetailViewModel?.gifImage = image
        self.gifDetailViewModel?.startAnimating()
        
        self.gifDetailViewModel?.didUpdate = {
            XCTAssertTrue(true)
        }
    }
    
    
    
    /////////////helper Functions////////////////
    @objc func  performBlock(block: ()->()) {
        block()
    }
    
    func performBlockAfterDelay(block: ()->(), delay: TimeInterval) {
        self.perform(#selector(performBlock(block:)), with: block, afterDelay: delay)
    }
    /////////////////////////////////////////////
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
