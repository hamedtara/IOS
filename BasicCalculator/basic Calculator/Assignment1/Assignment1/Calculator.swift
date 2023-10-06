//
//  Calculator.swift
//  Assignment1
//
//  Created by user234266 on 9/29/23.
//
import Foundation

class Calculator {
    private var currentInput: String = ""
    private var operand1: Double?
    private var operatorType: String?
    private var equation: String = ""
    private var equalCounter: Int=0
    

    func clear() {
        currentInput = ""
        operand1 = nil
        operatorType = nil
        equation = ""
        equalCounter = 0
    }


    func getCurrentInput() -> String {
        return currentInput
    }

    func getEquation() -> String {
        return equation
    }

    func getResult() -> Double? {
        
        return operand1
    }

    private func calculate(operand1: Double, operatorType: String, operand2: Double) -> Double? {
        switch operatorType {
        case "+":
            return operand1 + operand2
        case "-":
            return operand1 - operand2
        case "*":
            return operand1 * operand2
        case "/":
            if operand2 == 0 {
                return nil
            } else {
                return operand1 / operand2
            }
        default:
            return nil
        }
    }


    private func isOperator(_ input: String) -> Bool {
        
        
        var operatorCounts: [Character: Int] = ["+": 0, "-": 0, "*": 0, "/": 0]

        for char in input {
            if let count = operatorCounts[char] {
                operatorCounts[char] = count + 1
            }
        }
        return operatorCounts.values.allSatisfy { $0 <= 1 }
    }


    func processButtonPress(input: String) {
        if let number = Double(input) {
            currentInput += input
            equation += input
        } else if isOperator(input) {
            if !currentInput.isEmpty {
                if operand1 == nil {
                    operand1 = Double(currentInput)
                    operatorType = input
                    equation += " " + input + " "
                    currentInput = ""
                } else {
                    if let operand2 = Double(currentInput) {
                        if let result = calculate(operand1: operand1!, operatorType: operatorType!, operand2: operand2) {
                            operand1 = result
                            operatorType = input
                            equation = String(result) + " " + input + " "
                            currentInput = ""
                        } else {
                            clear()
                        }
                    }
                }
            }
        } else if input == "=" {
            if equalCounter == 0 {
                if let operand2 = Double(currentInput) {
                    if let result = calculate(operand1: operand1!, operatorType: operatorType!, operand2: operand2) {
                        operand1 = result
                        equation = equation + " " + input + " "
                        currentInput = String(result)
                    } else {
                        clear()
                    }
                }
            }
        } else if input == "C" {
            clear()
        }
    }


}
