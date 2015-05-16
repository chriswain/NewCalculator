//
//  ViewController.swift
//  NewCalculator
//
//  Created by Christopher Wainwright Aaron on 5/15/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var display: UILabel!
    
    var userTypingNumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
       
        if userTypingNumber {
        display.text = display.text! + digit
        } else {
            display.text = digit
            userTypingNumber = true
        }
       
        println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userTypingNumber {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $1 * $0 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $1 + $0 }
        case "−": performOperation { $1 - $0 }
        default: break
        }
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack: [Double] = []
   
    @IBAction func enter() {
        userTypingNumber = false
        operandStack.append(displayValue)
        println("operand stack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
          return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userTypingNumber = false
        }
    }
    
}

