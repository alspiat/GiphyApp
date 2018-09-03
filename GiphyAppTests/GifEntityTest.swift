//
//  GifEntityTest.swift
//  GiphyAppTests
//
//  Created by Dmitriy Tarelkin on 3/9/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifEntityTest: XCTestCase {
    var gif: GifEntity!
    var coreDataManager: CoreDataManager!

    
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
        self.gif = GifEntity(JSON: json)
        print(self.gif)
        self.coreDataManager = CoreDataManager()
    }
    
    override func tearDown() {
        self.coreDataManager = nil
        self.gif = nil
        super.tearDown()
    }
    

    func test_initWithInvalidJSONShouldReturnNil_Success() {
        let invalidJSON =  ["id": "feqkVgjJpYtjy",
        "ur": "https://giphy.com/gifs/eyes-shocked-bird-feqkVgjJpYtjy",
        "userame": "",
        "rating": "g",
        "contet_url": "",
        "source_tld": "littleanimalgifs.tumblr.com",
        "sorce_post_url": "https://littleanimalgifs.tumblr.com/post/17994517807",
        "impor_datetime": "2013-03-21 04:03:08",
        "trending_datetime": "2014-11-12 06:22:52",
        
        "imaes": [
        "fixed_height_still": [
        "ul": "https://media0.giphy.com/media/feqkVgjJpYtjy/200_s.gif",
        "width": "445",
        "height": "200"
            ]]] as [String : Any]
        let gifEntity = GifEntity(JSON: invalidJSON)
        XCTAssertFalse(gifEntity != nil)
    }
    
    func test_initWithValidJSONShouldReturnObject_Success() {
        let validJSON = [ "id": "feqkVgjJpYtjy",
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
        let gifEntity = GifEntity(JSON: validJSON)
        XCTAssertTrue(gifEntity != nil)
    }
    
    //init with managed object
    func test_initWithValidManagedObjectShouldReturnGifEntity_Success() {
        self.coreDataManager.addItem(self.gif)
        //this methods calls initWithMO and should returnObject
        let returnedGif = self.coreDataManager.getItemWithID(self.gif.id)
        XCTAssertTrue(returnedGif != nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
