//
//  GrailedChallengeTests.swift
//  GrailedChallengeTests
//
//  Created by jay on 5/9/17.
//  Copyright © 2017 jay. All rights reserved.
//

import XCTest
@testable import GrailedChallenge

class GrailedChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetch() {
        
        let exp = expectation(description: "Fetch Data")
        
        let model = DataModel()
        model.fetchListData() {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            if error != nil {
                XCTAssert(false)
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
