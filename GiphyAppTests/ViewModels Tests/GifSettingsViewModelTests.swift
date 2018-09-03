//
//  GifSettingsViewModelTests.swift
//  GiphyAppTests
//
//  Created by Dmitriy Tarelkin on 3/9/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifSettingsViewModelTests: XCTestCase {
    var gifViewModelSettings: SettingsViewModel?
    
    override func setUp() {
        super.setUp()
        self.gifViewModelSettings = SettingsViewModel()
    }
    
    override func tearDown() {
       self.gifViewModelSettings = nil
        super.tearDown()
    }
    
    func test_init_Success() {
     self.gifViewModelSettings?.userDefaults
     XCTAssertEqual(self.gifViewModelSettings?.currentRating, "unrated")
    }
    
    func test_saveRatingToUserDefaults_Success() {
        self.gifViewModelSettings?.userDefaults
        let setRating = self.gifViewModelSettings?.ratingItems.last
        self.gifViewModelSettings?.currentRating = setRating
        
        self.gifViewModelSettings?.saveRatingToUserDefaults()
        let returnRating = self.gifViewModelSettings?.ratingFromUserDefaults()
    XCTAssertEqual(setRating, returnRating)
    }
    
    func test_setCurrentRating_Success() {
        let setRating = self.gifViewModelSettings?.ratingItems.last
        self.gifViewModelSettings?.currentRating = setRating
        self.gifViewModelSettings?.setCurrentRating(index: 6)
        XCTAssertEqual(setRating, self.gifViewModelSettings?.currentRating)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
