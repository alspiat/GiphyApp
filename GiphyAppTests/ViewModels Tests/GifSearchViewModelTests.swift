//
//  GifSearchViewModel.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifSearchViewModelTests: XCTestCase {
    
    var gifSearchViewModel: GifSearchViewModel?
    var gifEntity:GifEntity?
    
    
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
        
        guard let gif = GifEntity(JSON: json) else {return XCTFail("GifSearchViewModelTests FAIl invalid JSON")}
            
        self.gifEntity = gif
        self.gifSearchViewModel = GifSearchViewModel(query: "cats")
     
    }
    
    override func tearDown() {
        self.gifEntity = nil
        self.gifSearchViewModel = nil
        super.tearDown()
    }
    
    
    
    func test_initWithQuery_Success() {
        let query = "cats"
        let viewModel = GifSearchViewModel(query: query)
        XCTAssertEqual(query, viewModel.title)
    }
    
    func test_loadDataIfNeeded_Success() {
        let query = "cats"
        var changingString = ""
        let comparableString = "queryWasChanged"
        let gifViewModel = GifSearchViewModel(query: query)
        let index = 10
        let expectation = self.expectation(description: "ready")
        
        gifViewModel.didUpdate = {
            expectation.fulfill()
            changingString = "queryWasChanged"
        }
        gifViewModel.loadDataIfNeeded(fromIndex: index)
        
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertEqual(comparableString, changingString)
        }
    }
    
    func test_loadDataIfNeeded_Failure() {
        let query = "cats"
        var changingString = ""
        let comparableString = "queryWasChanged"
        let gifViewModel = GifSearchViewModel(query: query)
        let index = -10
        
        gifViewModel.didUpdate = {
            //this block should not be executed
            changingString = "queryWasChanged"
        }
        gifViewModel.loadDataIfNeeded(fromIndex: index)
        
        XCTAssertNotEqual(comparableString, changingString)
    }
    
    func test_clearData_Success() {
        self.gifSearchViewModel?.clearData()
    }
    
    func test_viewModelForCell_Success() {
        //was tested
        let gifSearch = GifSearchViewModel(query: "cats")
        gifSearch.loadDataIfNeeded(fromIndex: 10)
        
        gifSearch.didUpdate = {
            let cell = gifSearch.viewModelForCell(at: 0)
            XCTAssertTrue(cell.gifEntity.publishingDate != nil)
        }
    }
    
    func test_contentSize_Success() {
        //don't need to be tested because it uses functions which were tested before
        let gifSearch = GifSearchViewModel(query: "cats")
        gifSearch.loadDataIfNeeded(fromIndex: 10)
       
        gifSearch.didUpdate = {
             let contentSize = gifSearch.contentSize(at: 0)
            XCTAssertTrue(contentSize != nil)
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
