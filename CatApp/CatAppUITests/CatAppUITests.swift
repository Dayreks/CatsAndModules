//
//  CatAppUITests.swift
//  CatAppUITests
//
//  Created by Bohdan on 06.07.2022.
//

import XCTest

class CatAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        sleep(4)
        
        let table = app.scrollViews.element (boundBy: 0)
        XCTAssert (table.exists)
        
        let cell = table.children(matching: .other).element (boundBy: 0)
        XCTAssert (cell.exists)
        
        snapshot ("Bohdan_Arkhypchuk_MainScreen")
        
        cell.tap()
        
        sleep(3)
        snapshot ("Bohdan_Arkhypchuk_DetailsScreen")
    }

    
}
