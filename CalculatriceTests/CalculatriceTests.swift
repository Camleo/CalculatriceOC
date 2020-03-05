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
    
    // MARK: - test unitaire
    
    // test isCorrect
    func testGivenexpressionHaveEnoughtElement_WhenStringgreaterThanOrEqualTo3_ThenReturnTrue() {
        calculator.numberOnScreen = "2 + 3"
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
    }
    
    
    func testGivenCalculStringHaveResult_WhenReset_ThenCalculStringIsEmpty(){
        calculator.clearNumber()
        
        XCTAssertEqual(calculator.numberOnScreen, "")
        
        
    }
    
    // test addOperator ( + )
    func testGivenCalculstringIsEmpty_WhenMakeOperation_ThenHaveResult(){
        calculator.numberOnScreen = "1 + 1"
        calculator.equal()
        XCTAssertEqual(calculator.numberOnScreen, "1 + 1 = 2")
        
    }
    
    // test notification "un operateur est deja mit"
    func testGivenCalculStringLastWithOperator_WhenAddingOperator_ThenNotificationTriggered(){
        calculator.numberOnScreen = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.addOperations("-")
        calculator.addOperations("+")
        calculator.addOperations("*")
        calculator.addOperations("/")
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    // test notification "entrer une expression correct"
    func testGivenCalculStringLastWithOperator_WhenMakingCalculation_ThenNotificationTriggered(){
        calculator.numberOnScreen = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testGivenCalculStringStartWithOperator_WhenMakingCalculation_ThenNotificationTriggered(){
        calculator.addOperations("*")
        XCTAssertEqual(calculator.numberOnScreen, "")
        
    }
    // test addOperator ( - )
    func testGivenCalculstringIsEmpty_WhenMakeMinusOperation_ThenHaveResult(){
        calculator.addNumber("1")
        calculator.addOperations("-")
        calculator.addNumber("1")
        calculator.equal()
        XCTAssertEqual(calculator.numberOnScreen, "1 - 1 = 0")
    }
    
    
    
    // test several operation (+ & /)
    func testGivenCalculIsEmpty_WhenMakingVariousOperation_ThenResultIsGood(){
        calculator.addNumber("6")
        calculator.addOperations("+")
        calculator.addNumber("4")
        calculator.equal()
        calculator.addOperations("/")
        calculator.addNumber("5")
        calculator.equal()
        XCTAssertTrue(calculator.numberOnScreen == "10 / 5 = 2")
    }
    
    func testGivenCalculHasBeenMade_WhenResultAndAddNumber_ThenResultIsNewNumber(){
        calculator.numberOnScreen = "6 + 4 = 10"
        calculator.addNumber("2")
        XCTAssertEqual(calculator.numberOnScreen, "2")
    }
    // test Dot
    func testGivenaddNumber_whenTappedDotNumber_ThenreturnNumber () {
        calculator.addNumber(".")
        XCTAssert(calculator.numberOnScreen == ".")
    }
    // test calculation with dot
    func testGivenNumberOnScreen_WhenDoOperations_ThenReceiveNotification() {
        expectation(forNotification: NSNotification.Name("error"), object: nil, handler: nil)
        calculator.numberOnScreen = "2.3"
        calculator.addOperations("b")
        calculator.equal()
        waitForExpectations(timeout: 0.1,  handler: nil)
    }
    // test addition dot
    func testGivenNumberWithoutDecimal_whenAddingDot_ThenAddDot() {
        calculator.numberOnScreen = "2"
        calculator.addNumber(".")
        XCTAssertEqual(calculator.numberOnScreen, "2.")
    }
    
    func testGivenNumberWithDecimal_WhenAddingDot_ThenReceiveNotification() {
        expectation(forNotification: NSNotification.Name("error"), object: nil, handler: nil)
        calculator.numberOnScreen = "2.3"
        calculator.addNumber (".")
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    // test Division by 0
    func testGivenCalculStringIsEmpty_WhenMakeDivisionByZero_ThenHaveAnError() {
        calculator.numberOnScreen = "2 / 0"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    // test Double tapped equal
    func testGivenCalculStringIsEmptyAnother_WhenTappedTwoTimesEqual_ThenHaveAnError() {
        calculator.numberOnScreen = "2 + 2 = 4"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
        
        
    }
    
    // MARK: -TDD
    
    
    func testGivenCalculstringIsEmpty_WhenMakeMultiplicationOperation_ThenHaveResult(){
        
        calculator.addNumber("2")
        calculator.addOperations("*")
        calculator.addNumber("3")
        calculator.equal()
        XCTAssertEqual(calculator.numberOnScreen, "2 x 3 = 6")
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDivisionOperation_ThenHaveResult(){
        
        calculator.addNumber("6")
        calculator.addOperations("/")
        calculator.addNumber("3")
        calculator.equal()
        
        XCTAssertEqual(calculator.numberOnScreen, "6 / 3 = 2")
        
    }
    
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addOperations("+")
        calculator.addNumber("3")
        calculator.addOperations("*")
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.numberOnScreen, "6 + 3 x 2 = 12")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndDivisionOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addOperations("+")
        calculator.addNumber("4")
        calculator.addOperations("/")
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.numberOnScreen, "6 + 4 / 2 = 8")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationAndDivisionOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addOperations("+")
        calculator.addNumber("4")
        calculator.addOperations("*")
        calculator.addNumber("10")
        calculator.addOperations("/")
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.numberOnScreen, "6 + 4 x 10 / 2 = 26")
        
    }
    
    
}
