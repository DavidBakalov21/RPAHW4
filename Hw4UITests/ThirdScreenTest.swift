//
//  ThirdScreenTest.swift
//  Hw4
//
//  Created by david david on 21.11.2024.
//
import XCTest
// look for more references in other test classes
// https://stackoverflow.com/questions/51621445/perform-a-full-swipe-left-action-in-ui-tests
final class ThirdScreenTests: XCTestCase {
    var app: XCUIApplication!

       override func setUp() {
           super.setUp()
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
       }
    func testLabelAtTheSecondScreen() {
        let secondTab = app.tabBars.buttons["Third"]
        
            secondTab.tap()
        XCTAssertTrue(app.staticTexts["likedLabel"].exists, "Cats label should be present")
        XCTAssertEqual(app.staticTexts["likedLabel"].label, "Liked Cats", "The label should be Liked Cats")
            
       }
    func testTableSecondScreen() {
        let secondTab = app.tabBars.buttons["Third"]
            secondTab.tap()
        XCTAssertTrue(app.tables["catsImages"].exists, "Cats table should be present")
            
       }
    func testTableCheckLiked() {
        let card = app.otherElements["Card"]
    
        card.swipeLeft()
        let secondTab = app.tabBars.buttons["Third"]
        secondTab.tap()

        let tableView = app.tables["catsImages"]
     
        XCTAssertTrue(tableView.cells.count>0, "There should be at least one cat")
    }
    
    func testTableCheckLiked2() {
        let card = app.otherElements["Card"]
    
        card.swipeRight()
        let secondTab = app.tabBars.buttons["Third"]
        secondTab.tap()

        let tableView = app.tables["catsImages"]
     
        XCTAssertTrue(tableView.cells.count==0, "there should be no cats")
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
