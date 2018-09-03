//
//  APITypesTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 9/3/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class APITypesTests: XCTestCase {
    var apiResulttype: APIResult<Any>?
    var apiErrorType: APIErrorType?
    var apiRequestType: APIRequestType?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    //NoDatareturned
    func test_ApiErrorTypeDescription_NoDataReturned_Success() {
        let descriptionString = APIErrorType.NoDataReturned.description
        XCTAssertEqual(descriptionString, "No data returned")
    }
    
    func test_ApiErrorTypeDescription_InvalidDataFormat_Success() {
        let descriptionString = APIErrorType.InvalidDataFormat.description
        XCTAssertEqual(descriptionString, "Parsing was failed")
    }
    
    func test_ApiErrorTypeDescription_ConnectionFailed_Success() {
        enum MyError: Error {
            case someExpectedError
            case someUnexpectedError
        }
        
        let descriptionString = APIErrorType.ConnectionFailed(MyError.someExpectedError).description
        let expectedStringResult = "Connection failed: \(MyError.someExpectedError.localizedDescription)"
        XCTAssertEqual(descriptionString, expectedStringResult)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
