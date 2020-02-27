//
//  CalculatriceTests.swift
//  CalculatriceTests
//
//  Created by rochdi ben abdeljelil on 21.02.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import XCTest
@testable import Calculatrice

class CalculatriceTests: XCTestCase {
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    func testGivenexpressionHaveEnoughtElement_WhenStringgreaterThanOrEqualTo3_ThenReturnTrue() {
        calculator.numberOnScreen = "2 + 3"
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
    }
    func testGivencanAddOperator_WhencanAddOperator_ThenReturnTrue() {
        calculator.numberOnScreen = "2 + 3 + 2"
        XCTAssertTrue(calculator.canAddOperator)
    }
    func testGivenexpressionHaveResult_WhenexpressionHaveResult_ThenReturnTrue() {
        calculator.numberOnScreen = "= 20"
        XCTAssertTrue(calculator.expressionHaveResult)
    }
    func testGivendivideByZero_WhendivideByZero_ThenReturnNotification() {
        calculator.numberOnScreen = " 2 / 0"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    func testGivenaddNumber_whenTappedButtonNumber_ThenreturnNumber() {
        calculator.addNumber("3")
        XCTAssert(calculator.numberOnScreen == "3")
    }
    func testGivenclearNumber_whenTappedClearButton_ThenreturnTrue() {
        calculator.clearNumber()
        XCTAssertTrue(calculator.numberOnScreen == "")
    }
    func testGivenaddOperations_whenaddOperations_ThenreturnFalse() {
        calculator.addOperations("+")
        XCTAssertFalse(calculator.numberOnScreen == "+")
    }
    func testGivencalcul_whenCalculate_ThenreturnTrue() {
        let result = calculator.calcul( left : 2.0, right : 4.0, operand : "+")
        XCTAssertTrue(result == 6)
    }
    func testGivenCalculStringIsEmptyAnother_WhenTappedEqualButton_ThenHaveAnError() {
        
        calculator.numberOnScreen = "2 + 2 = 4"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
        
        
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
