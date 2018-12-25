//
//  Mobile_DataTests.swift
//  Mobile DataTests
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//

import XCTest
@testable import Mobile_Data

class Mobile_DataTests: XCTestCase {
    var firstViewModel: FirstViewModel!
    var secondViewModel: SecondViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        firstViewModel = FirstViewModel()
        secondViewModel = SecondViewModel()
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        firstViewModel = nil
        secondViewModel = nil
    }

    func test_FirstExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "First Service Request")
        firstViewModel.unitTestpreSetup(closure: { (success, data) in
            //TEST:
            XCTAssertEqual(success, true)
            XCTAssertNotNil(data, "request should not nil")
            expectation.fulfill()
        })
        firstViewModel.loadChartData()
        wait(for: [expectation], timeout: 10.0)
    }
    func test_SecondExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "Second Service Request")
        secondViewModel.unitTestpreSetup(closure: { (success, data) in
            //TEST:
            XCTAssertEqual(success, true)
            XCTAssertNotNil(data, "request should not nil")
            expectation.fulfill()
        })
        secondViewModel.loadChartData()
        wait(for: [expectation], timeout: 10.0)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
