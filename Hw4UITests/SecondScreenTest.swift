//
//  SecondScreenTest.swift
//  Hw4
//
//  Created by david david on 21.11.2024.
//

//
//  Hw4UITests.swift
//  Hw4UITests
//
//  Created by david david on 06.11.2024.
//

import XCTest
// https://medium.com/@sovata8/xcode-ui-testing-button-interactions
// -exploring-tap-exists-and-waiting-with-predicates-1e344b3c2e60
// https://stackoverflow.com/questions/32365327/how-can-i-verify-existence
// -of-text-inside-a-table-view-row-given-its-index-in-an
// https://medium.com/appledeveloperacademy-ufpe/how-to-
// implement-ui-tests-with-swiftui-a-few-examples-636708ee26ad
// https://swiftwithmajid.com/2021/03/18/ui-testing-in-swift-with-xctest-framework/
// https://developer.apple.com/documentation/xctest/xctestcase/set_up_and_tear_down_state_in_your_tests
final class SecondScreenTests: XCTestCase {
    var app: XCUIApplication!

       override func setUp() {
           super.setUp()
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
       }
    func testLabelAtTheSecondScreen() {
        let secondTab = app.tabBars.buttons["Second"]
            secondTab.tap()
        XCTAssertTrue(app.staticTexts["catsLabel"].exists, "Cats label should be present")
        XCTAssertEqual(app.staticTexts["catsLabel"].label, "Cats", "The label should be Cats")
       }
    func testTableSecondScreen() {
        let secondTab = app.tabBars.buttons["Second"]
            secondTab.tap()
        XCTAssertTrue(app.tables["breedsCats"].exists, "Cats table should be present")
            
       }
    func testCheckSpinnerAtTheSeconsScreen() {
        let secondTab = app.tabBars.buttons["Second"]
            secondTab.tap()
            XCTAssertFalse(app.otherElements["Spinner"].exists, "spinner should not be present")
            
       }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
