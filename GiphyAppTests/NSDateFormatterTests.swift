//
//  NSDateFormatterTests.swift
//  GiphyAppTests
//
//  Created by Dmitriy Tarelkin on 3/9/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class NSDateFormatterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    func test_getRightDateShouldReturnValue_Success() {
        let inputString = "2018-09-24 12:00:00"
        let result = Date.date(string: inputString)
        XCTAssertEqual(result, getDate(), "String convertion to Date should be success")
    }
    
    func test_getRightDateShouldReturnNil_Failure() {
        let inputString = "2018000-100-224 123:200:00"
        let result = Date.date(string: inputString)
        XCTAssertTrue(result == nil)
    }
    
    
    func test_formattedStringFromDate_Success() {
        let currentDate = Date()
        let stringDate = currentDate.formattedString()
        XCTAssertEqual(stringDate, stringFromDateWithFormatString(date: Date()))
    }
    
    
    //helper functions
    func getDate() -> Date {
        var date = DateComponents()
        date.year = 2018
        date.month = 9
        date.day = 24
        date.hour = 12
        date.minute = 0
        date.second = 0
        
        let userCalendar = Calendar.current
        let someDateTime = userCalendar.date(from: date)
        
        return someDateTime!
    }
    
   
    
    //NSDate tests
    func test_formattedStringNSDate_Success() {
        let nsdate = NSDate()
        let date = Date()
        //expected result
        let expectedResult = self.stringFromDateWithFormatString(date: date)
        let stringDate = nsdate.formattedString()
        
        XCTAssertEqual(expectedResult, stringDate)
    }
    
    //helpers
    func stringFromDateWithFormatString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
