//
//  ViewControllerUITests.swift
//  testprojectUITests
//
//  Created by Revan SADIGLI on 13.01.2024.
//

import XCTest

class ViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testDropdownAndTextField() throws {
        let app = XCUIApplication()
        let dropdownTextField = app.textFields["Select Langauge"]
        let textField = app.textFields["Enter text here"]

        dropdownTextField.tap()

        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "English")

        XCTAssertEqual(dropdownTextField.value as? String, "English")

        textField.tap()
        textField.typeText("This is a test sentence if the ui test working")

        sleep(1)

        let tableView = app.tables.element
        XCTAssertTrue(tableView.cells.count == 2)
    }
}
