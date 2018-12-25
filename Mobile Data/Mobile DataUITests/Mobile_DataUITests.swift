//
//  Mobile_DataUITests.swift
//  Mobile DataUITests
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import Mobile_Data
class Mobile_DataUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FirstViewController() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.otherElements[" : Q2\n18.4737 "]/*[[".cells.otherElements[\" : Q2\\n18.4737 \"]",".otherElements[\" : Q2\\n18.4737 \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.otherElements[" : Q3\n12.1423 "]/*[[".cells.otherElements[\" : Q3\\n12.1423 \"]",".otherElements[\" : Q3\\n12.1423 \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
    }
    func test_SecondViewController() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Chart"].tap()
        
        let lineChart1DatasetElement = app.otherElements["Line Chart. 1 dataset. "]
        lineChart1DatasetElement.swipeRight()
        lineChart1DatasetElement/*@START_MENU_TOKEN@*/.press(forDuration: 0.5);/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lineChart1DatasetElement/*@START_MENU_TOKEN@*/.press(forDuration: 1.1);/*[[".tap()",".press(forDuration: 1.1);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lineChart1DatasetElement.tap()
        lineChart1DatasetElement.tap()
        lineChart1DatasetElement.tap()
        
    }

}
