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
    
    override func setUp() {
        super.setUp()
        self.fileManager = AppFileManager()
    }
    
    override func tearDown() {
        self.fileManager = nil
        super.tearDown()
    }
    
    
    //loadImageData
    func test_loadImageData_Success(){
        
    }
    
    //loadPreviewImageData
    func test_loadPreviewImageData_Success() {
        let json:JSON = ["id":"myId", "url":"url1",
                         "height": "120", "width":"200",
                         "preview_gif": ["url": "http://media2.giphy.com/media/FiGiRei2ICzzG/200w.gif",
                                         "width": "200",
                                         "height": "70"],
                         "original": ["url": "http://media2.giphy.com/media/FiGiRei2ICzzG/200w_d.gif",
                                      "width": "200",
                                      "height": "70"]]
        
        
        
        let gifEntity = GifEntity(JSON: json)
//        let image = GifImage(JSON: json)
//        gifEntity?.originImage = image!
        var myData: Data?
        
    
        let expectation:XCTestExpectation  = self.expectation(description: "success")
         DataManager.loadOriginalImageData(gifEntity, previewFirstly: true, completionHandler:  {(data) in
            myData = data
            print(myData)
            expectation.fulfill()
        })
        
            self.waitForExpectations(timeout: 5, handler: { (error) in
                if error != nil {
                    print("error occured \(error.debugDescription)")
                }
            })
    
        XCTAssert(myData != nil, "Data exists")
        
    }
    
    //loadOriginalImageData
    func test_loadOriginalImageData_Success(){
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
