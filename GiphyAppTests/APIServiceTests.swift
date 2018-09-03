//
//  APIServiceTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class APIServiceTests: XCTestCase {
    var api: APIService!
    
    override func setUp() {
        super.setUp()
        self.api = APIService.shared
    }
    
    override func tearDown() {
        self.api = nil
        super.tearDown()
    }
    
    //fetch Data
    func test_fetchData_Success() {
        let someURlString = "https://giphy.com/gifs/eyes-shocked-bird-feqkVgjJpYtjy"
        var expectedData: Data?
        let expectation:XCTestExpectation = self.expectation(description: "this method should download data from internet")
        let dataTask = self.api.fetchData(URL: URL(string: someURlString)) { (data) in
            expectedData = data
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(expectedData != nil )
        }
      
        
    }
    
    //fetchSearch
    func test_fetchSearch_Success() {
        let requestString = "cats"
        var gifArray: [GifEntity]?
        
        let expectation:XCTestExpectation = self.expectation(description: "this method should download data from internet with search query")
        
    
        self.api.fetchSearch(query: requestString, offset: 20, limit: 24, rating: .ratedPG) { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    gifArray = gifEntities
                    print("this is gif array : \(gifEntities)")
                    expectation.fulfill()
                }
            case .Failure(let apiError):
                print(apiError.description)
            }
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(gifArray != nil)
    }
    
    func test_fetchSearch_invalidQuery_Failure() {
        let requestString = "dkjsdkjf322342"
        var gifArray: [GifEntity]?
        
        let expectation:XCTestExpectation = self.expectation(description: "this method should download data from internet with search query")
        
        
        self.api.fetchSearch(query: requestString, offset: 20, limit: 24, rating: .ratedPG) { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    gifArray = gifEntities
                    print("this is gif array : \(gifEntities)")
                    expectation.fulfill()
                }
            case .Failure(let apiError):
                print(apiError.description)
            }
           
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(gifArray != nil)
    }
    
    
    
    
    
    //fetch trending
    func test_fetchTrending_Success() {
        var gifArray: [GifEntity]?
        
        let expectation:XCTestExpectation = self.expectation(description: "this method should download data from internet with search query")
        
        
        self.api.fetchTrending(offset: 20, limit: 24, rating: .unrated, completionHandler: { (result) in
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    gifArray = gifEntities
                    print("this is gif array : \(gifEntities)")
                }
            case .Failure(let apiError):
                print(apiError.description)
            }
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(gifArray != nil)
    }
    

    func test_fetch_trending_Error_Success() {
        var gifArray: [GifEntity]?
        
        let expectation:XCTestExpectation = self.expectation(description: "this method should download data from internet with search query")
        
        
        self.api.fetchTrending(offset: -110, limit: -122, rating: .unrated, completionHandler: { (result) in
            
            switch result {
            case .Success(let gifEntities):
                DispatchQueue.main.async {
                    gifArray?.append(contentsOf: gifEntities)
                    print("this is gif array : \(gifEntities)")
                }
            case .Failure(let apiError):
                print(apiError.description)
            }
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(gifArray == nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
