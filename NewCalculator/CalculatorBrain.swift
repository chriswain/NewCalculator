//
//  CalculatorBrain.swift
//  NewCalculator
//
//  Created by Christopher Wainwright Aaron on 5/16/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
       case Operand(Double)
       case UnaryOperation(String, Double -> Double)
       case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    var opStack = [Op]()
    var knownOps = [String: Op]()
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
   
    func pushOperand (operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation (symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
           var remainingOps = ops
           let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand): return(operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return(operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1evaluation = evaluate(remainingOps)
                if let operand1 = op1evaluation.result {
                    let op2evaluation = evaluate(op1evaluation.remainingOps)
                    if let operand2 = op2evaluation.result {
                        return (operation(operand1, operand2), op2evaluation.remainingOps)
                    }
                }
                
            }
        }
       
        return(nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainingOps) = evaluate(opStack)
        return result
    }
}
