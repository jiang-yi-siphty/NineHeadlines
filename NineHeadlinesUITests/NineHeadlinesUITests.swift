//
//  NineHeadlinesUITests.swift
//  NineHeadlinesUITests
//
//  Created by Yi JIANG on 12/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import XCTest

class NineHeadlinesUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
        
        let app = XCUIApplication()

        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Evans Dixon CEO quits to focus on ailing US fund"].tap()
        app.navigationBars["Nine Headlines"].buttons["Nine Headlines"].tap()
        
        XCTAssertEqual(app.tables.count, 1)
    }

}
