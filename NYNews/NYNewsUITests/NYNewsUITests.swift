//
//  NYNewsUITests.swift
//  NYNewsUITests
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import XCTest

class NYNewsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetNewsByPullingToRefresh() {
        let tablesQuery = app.tables
        let firstCell = tablesQuery.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector.init(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector.init(dx: 0, dy: 5))
        start.press(forDuration: 0, thenDragTo: finish)
    }

    func testShowDetailsByTapping() {
        let tablesQuery = app.tables
        let firstCell = tablesQuery.cells.firstMatch
        firstCell.tap()
        app.navigationBars["News Detail"].buttons["NY News"].tap()
    }

}
