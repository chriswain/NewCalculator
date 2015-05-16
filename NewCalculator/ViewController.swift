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
    
    var brain = CalculatorBrain()

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
        
        
    }
    
  
 
   
    @IBAction func enter() {
        userTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
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

