//
//  MercariTests.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/29/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import XCTest
@testable import Mercari

class MercariTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    ///FetchManager tests
    func testGetItemsInFetchManager() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        FetchManager.getItems { (success, error) in
            XCTAssertTrue(success, "Error getting items in FetchManager")
        }
    }
    
    ///NetworkManager tests
    func testGetItemsInNetworkManager() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        NetworkManager.getItems { (json, error) in
            XCTAssertNotNil(json, "Error getting items in NetworkManager")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
