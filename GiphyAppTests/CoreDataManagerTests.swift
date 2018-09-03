//
//  CoreDataManagerTests.swift
//  GiphyAppTests
//
//  Created by Dmitriy Tarelkin on 2/9/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager?
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
        self.gif = nil
        self.coreDataManager = nil
        super.tearDown()
    }
    
    
    func test_getAllData_Success() {
        let result = self.coreDataManager?.getAllItems()
        guard let res = result else { return XCTAssertTrue(result == nil)}
        
        XCTAssert(res.count > 0, "res:\(res.count)")
    }
    
    
    func test_getItem_With_id_Failure() {
        guard let manager = self.coreDataManager else {return}
        
        manager.addItem(self.gif)
        let gifItem =  manager.getItemWithID(self.gif.id)
        XCTAssertFalse(gifItem == self.gif)
    }
    
    
    func test_addItem_Success() {
        guard let manager = self.coreDataManager else {return}
        
        manager.addItem(self.gif)
        XCTAssertTrue(manager.itemExists(withID: self.gif.id))
        manager.deleteItem(self.gif)
    }
    
    func test_deletaItem_Success() {
        guard let manager = self.coreDataManager else {return}
        let someGif = self.gif
        someGif?.id = "someNewid"
        manager.addItem(someGif)
        manager.deleteItem(someGif)
        XCTAssertFalse(manager.itemExists(withID: someGif?.id))
    }
    
    func test_itemExistsWithId_Success() {
     guard let manager = self.coreDataManager else {return}
        
        XCTAssertFalse(manager.itemExists(withID: "failID"))
    }
    
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
