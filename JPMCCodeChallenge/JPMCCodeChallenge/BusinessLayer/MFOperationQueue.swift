//
//  MFOperationQueue.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

/**
 `MFOperationQueue` is an `NSOperationQueue` subclass that implements a couple
 of "extra features" related to the `MFOperation` class:
 
 - Extracting generated dependencies from operation conditions
 */

class MFOperationQueue: OperationQueue {
    
    override func addOperation(_ op: Operation) {
        
        // Extract any dependencies needed by this operation.
        if let mfOperation = op as? MFOperation {
            
            evaluateActiveDependenciesForTasks(mfOperation)
            
            for condition in mfOperation.conditions {
                mfOperation.addDependency(condition)
                self.addOperation(condition)
            }
        }
        
        super.addOperation(op)
    }
    
    override func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool) {
        /*
        The base implementation of this method does not call `addOperation()`,
        so we'll call it ourselves.
        */
        for operation in ops {
            addOperation(operation)
        }
        
        if wait {
            for operation in ops {
                operation.waitUntilFinished()
            }
        }
    }

    func evaluateActiveDependenciesForTasks(_ mfOperation: MFOperation) {
        if operations.count > 0 {
            for operation in operations {
                for condition in mfOperation.conditions where operation.name == condition.name {
                    mfOperation.removeCondition(condition)
                    mfOperation.addDependency(operation)
                }
            }
        }
    }
    
    func retrieveOperation(_ operationName: String) -> Operation? {
        return operations.first(where: { $0.name == operationName })
    }
    
    func retrieveOperations(_ operationName: String) -> [Operation] {
        return operations.filter { ($0.name ?? "") == operationName }
    }
    
    func cancelOperation(_ operationName: String) -> Bool {
        if let op = retrieveOperation(operationName) {
            if !op.isCancelled && !op.isFinished {
                op.cancel()
                return true
            }
        }
        return false
     }
    
    func cancelOperations(_ name: String) {
        let ops = retrieveOperations(name)
        
        for operation in ops {
            if !operation.isCancelled && !operation.isFinished {
                operation.cancel()
            }
        }
    }
}
