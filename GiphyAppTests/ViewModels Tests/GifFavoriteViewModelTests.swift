//
//  GifFavoriteViewModelTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 9/3/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifFavoriteViewModelTests: XCTestCase {
    var gifFavoritesViewModel : GifFavouritesViewModel?
    var gifEntity: GifEntity?
    
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
            self.gifFavoritesViewModel = GifFavouritesViewModel()
            self.gifEntity = gif
        }
        
    }
    
    override func tearDown() {
        self.gifEntity = nil
        self.gifFavoritesViewModel = nil
    }

    
    func test_loadDataIfNeeded_Success() {
        //call inside CoreDataManager functions which were tested by CoreDataManager
    }
    
    func test_viewModelForCell_Success() {
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
    
    func test_contentSize_Success() {
        let coreDataManager = CoreDataManager()
        coreDataManager.addItem(self.gifEntity)
        self.gifFavoritesViewModel?.loadDataIfNeeded(fromIndex: 0)
        let contentSize = self.gifFavoritesViewModel?.contentSize(at: 0)
        let expectedSize = CGSize(width: 138, height: 74)
        
        XCTAssertEqual(contentSize, expectedSize)
    }
    
    func test_clearCoreData_Sucess() {
        //don't need to be tested
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
