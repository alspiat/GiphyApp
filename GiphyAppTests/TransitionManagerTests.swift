//
//  TransitionManagerTests.swift
//  GiphyAppTests
//
//  Created by Dzmitry Tarelkin on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import XCTest
@testable import GiphyApp

class TransitionManagerTests: XCTestCase {
    var transitionManager: CircularControllerTransition?
    
    override func setUp() {
        super.setUp()
        self.transitionManager = CircularControllerTransition()
    }
    
    override func tearDown() {
        super.tearDown()
        self.transitionManager = nil
    }
    
    func test_duration_Success() {
        let timeInterval = self.transitionManager?.transitionDuration(using: nil)
        XCTAssertEqual(self.transitionManager?.duration, timeInterval)
    }
    
    func test_animateTransition_Success()  {
    }
    
    func test_frameForCircle_Success(){
        let viewCenter = CGPoint(x: 384, y: 512)
        let viewSize = CGSize(width: 768, height: 1024)
        let startPoint = CGPoint(x: 384, y: 340.070381231672)
        
        let trueResult = CGRect(origin: CGPoint.zero, size: CGSize(width: 1568, height: 1568))
        
        let returnigRect = (self.transitionManager?.frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startPoint))!
        
        XCTAssertEqual(CGRect(x: returnigRect.origin.x, y: returnigRect.origin.y,
                              width: CGFloat(Int((returnigRect.size.width))),
                              height: CGFloat(Int((returnigRect.size.height)))),
                              trueResult)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
