//
//  DataManagerTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

//FIXME: DataManager

class DataManagerTests: XCTestCase {
    var fileManager:AppFileManager?
    var gif: GifEntity!
    
    override func setUp() {
        super.setUp()
        let json:JSON = [
            "id": "feqkVgjJpYtjy",
            "url": "https://giphy.com/gifs/eyes-shocked-bird-feqkVgjJpYtjy",
            "username": "",
            "rating": "g",
            "content_url": "",
            "source_tld": "littleanimalgifs.tumblr.com",
            "source_post_url": "http://littleanimalgifs.tumblr.com/post/17994517807",
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
                    "webp": "https://media0.giphy.com/media/feqkVgjJpYtjy/200_d.webp",
                    "webp_size": "89516"
                ],
                "original": [
                    "url": "https://media0.giphy.com/media/feqkVgjJpYtjy/giphy.gif",
                    "width": "334",
                    "height": "150",
                    "size": "511581",
                    "frames": "27",
                    "mp4": "https://media0.giphy.com/media/feqkVgjJpYtjy/giphy.mp4",
                    "mp4_size": "97841",
                    "webp": "http://media0.giphy.com/media/feqkVgjJpYtjy/giphy.webp",
                    "webp_size": "270108"
                ],
                
            ],
            "title": "Shocked Eyes GIF",
            ]
        
        self.gif = GifEntity(JSON: json)
        self.fileManager = AppFileManager()
    }
    
    override func tearDown() {
        self.gif = nil
        self.fileManager = nil
        super.tearDown()
    }
    
    //WARNING: multiple fullFilltrouble
    //loadPreviewImageData
    /*
    func test_loadPreviewImageData_Success() {
        var resultData:Data?
        let expectation:XCTestExpectation  = self.expectation(description: "success")
        
        DataManager.loadPreviewImageData(self.gif) { (data) in
            resultData = data
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler:nil)
        XCTAssert(resultData != nil, "preview image data should not be nil")
    }
    */
    
    /*
    //loadOriginalImageData
    func test_loadOriginalImageDataPreviewFirstly_Success(){
        var resultData:Data?
        let expectation:XCTestExpectation  = self.expectation(description: "success")
        
        DataManager.loadOriginalImageData(self.gif, previewFirstly: true, completionHandler:  {(data) in
            print(data)
            resultData = data
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 5, handler:nil)
        XCTAssert(resultData != nil, "original image data should not be nil")
    }
    
    
    func test_loadOriginalImageData_Success(){
        var resultData:Data?
        let expectation:XCTestExpectation  = self.expectation(description: "success")
        
        DataManager.loadOriginalImageData(self.gif, previewFirstly: false, completionHandler:  {(data) in
            print(data)
            resultData = data
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 5, handler:nil)
        XCTAssert(resultData != nil, "original image data should not be nil")
    }
 */
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
