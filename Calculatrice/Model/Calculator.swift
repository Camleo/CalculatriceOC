//
//  Calculator.swift
//  Calculatrice
//
//  Created by rochdi ben abdeljelil on 20.02.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
class Calculator {
    var numberOnScreen = "" {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name("updateCalcul")))
        }
    }
     var elements: [String] {
        return  numberOnScreen.split(separator: " ").map { "\($0)" }
    }
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    var expressionHaveResult: Bool {
        return numberOnScreen.firstIndex(of: "=") != nil
    }
    var divideByZero: Bool {
        return numberOnScreen.contains("/ 0")
    }
    func addNumber(_ number: String) {
        if expressionHaveResult {
            numberOnScreen = ""
        }
        numberOnScreen.append(number)
    }
    func result() {
        if expressionHaveResult {
            if let result = elements.last {
                numberOnScreen = result
            }
        }
    }
    func dotPressed( left: Double, right: Double ) {
        numberOnScreen = String(left + right)
    }
    func clearNumber() {
        numberOnScreen = ""
    }
    func addOperations(_ element: String) {
        result()
        if canAddOperator {
            switch element {
            case " + ":
                numberOnScreen.append(" + ")
            case " - ":
                numberOnScreen.append(" - ")
            case " * ":
                numberOnScreen.append(" x ")
            case " / ":
                numberOnScreen.append(" / ")
            case ".":
                numberOnScreen.append(" . ")
            default:
                break
            }
        } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"),
                                                         userInfo: ["message": "Un operateur est déja mis !"]))
        }
    }
    func format(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = 8
        guard let stringNumber = formatter.string(from: NSNumber(value: number)) else { return ""}
        return stringNumber
    }
    // Create local copy of operations
    func calcul(left: Double, right: Double, operand: String) -> Double {
        var result: Double = 0
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "x": result = left * right
        case "/": result = left / right
        default: break
        }
        return result
    }
    func equal() {
        guard !expressionHaveResult else {
            return NotificationCenter.default.post(Notification(name: Notification.Name("error"),
                                                                userInfo: ["message": "Entrez une nouvelle opération"]))
        }
        guard expressionIsCorrect else {
            numberOnScreen = ""
            return NotificationCenter.default.post(Notification(name: Notification.Name("error"),
                                                            userInfo: ["message": "Entrez une expression correcte"]))
        }
        guard expressionHaveEnoughElement else {
            return NotificationCenter.default.post(Notification(name: Notification.Name("error"),
                                                                userInfo: ["message": "Commencez un nouveau calcul"]))
        }
        guard divideByZero == false else {
            numberOnScreen = ""
            return  NotificationCenter.default.post(Notification(name: Notification.Name("error"),
                                                                 userInfo: ["message": "Division par 0 impossible"]))
        }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var left = Double(operationsToReduce[0])!
            var operand = operationsToReduce[1]
            var right = Double(operationsToReduce[2])!
            var operandIndex = 1 // because no sign will be at base index 0 otherwise error
            let result: Double
            if let index = operationsToReduce.firstIndex(where: {["x", "/"].contains($0)}) {
                operandIndex = index
                left = Double(operationsToReduce[index - 1])!
                operand = operationsToReduce[index]
                right = Double(operationsToReduce[index + 1])!
            }
            result = calcul(left: left, right: right, operand: operand)
            for _ in 1...3 {
                operationsToReduce.remove(at: operandIndex - 1)
            }
            operationsToReduce.insert(format(result), at: operandIndex - 1 )
        }
        numberOnScreen.append(" = \(operationsToReduce.first!)")
    }
}
