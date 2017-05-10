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
    
    func testDate() {
        let dateString = "2017-05-10T01:42:55.986Z"
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        let date = formatter.date(from: dateString)!
        let cal = Calendar.current
        // not gonna worry about time zones
        XCTAssert(cal.component(.year, from: date) == 2017)
        XCTAssert(cal.component(.month, from: date) == 5)
        XCTAssert(cal.component(.day, from: date) == 9)
        XCTAssert(cal.component(.hour, from: date) == 21)
        XCTAssert(cal.component(.minute, from: date) == 42)
        XCTAssert(cal.component(.second, from: date) == 55)
    }
    
    func testSingleFetch() {
        let exp = expectation(description: "Fetch Data")
        let model = DataService()
        model.fetchListData(for: 1) {result in
            
            switch result {
            case .error(_):
                XCTAssert(false)
            case let .success(data):
                XCTAssert(data.count == 20)
            }
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
