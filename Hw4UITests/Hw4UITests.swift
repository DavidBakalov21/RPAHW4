//
//  Hw4UITests.swift
//  Hw4UITests
//
//  Created by david david on 06.11.2024.
//

import XCTest
//https://swiftwithmajid.com/2021/03/18/ui-testing-in-swift-with-xctest-framework/
//https://developer.apple.com/documentation/xctest/xctestcase/set_up_and_tear_down_state_in_your_tests
//https://stackoverflow.com/questions/34274341/how-can-i-test-for-the-existence-of-a-uiview-using-xcuielementsquery
final class MainScreenTests: XCTestCase {
    var app: XCUIApplication!

       override func setUp() {
           continueAfterFailure = false
           app = XCUIApplication()
           app.launchArguments = ["testing"]
           app.launch()
       }
    func testCheckCard() {
            XCTAssertTrue(app.otherElements["card"].exists, "card should be present")
            
       }
    func testCheckButtonLike() {
        XCTAssertTrue(app.buttons["buttonLike"].exists, "button like is missing")
            
       }
    
    func testCheckButtonDisLike() {
        XCTAssertTrue(app.buttons["buttonDislike"].exists, "button dislike is missing")
       }
  
    func testCheckIfButtonLikeClickable() {
            XCTAssertTrue(app.buttons["buttonLike"].isHittable, "button like isn't clickable")
       }
    func testCheckIfButtonDisLikeClickable() {
            XCTAssertTrue(app.buttons["buttonDislike"].isHittable, "button dislike isn't clickable")
       }
    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
