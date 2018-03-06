//
//  MFOperation.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

/**
 The subclass of `NSOperation` from which all other operations should be derived.
 This class adds Conditions, which allow the operation to define
 extended readiness requirements
 */

class MFOperation: Operation {
    fileprivate var _executing: Bool = false
    override var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    fileprivate var _finished: Bool = false
    override var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var isMutuallyExclusive = false
    
    fileprivate(set) var errors = [Error]()
    
    func addError(_ error: Error) {
        errors.append(error)
    }
    
    fileprivate(set) var conditions = [MFOperation]()
    
    func addCondition(_ condition: MFOperation) {
        conditions.append(condition)
    }
    
    func removeCondition(_ condition: MFOperation) {
        if let index = conditions.index(of: condition) {
            conditions.remove(at: index)
        }
    }
    
    override final func start() {
        // NSOperation.start() contains important logic that shouldn't be bypassed.
        
        super.start()
        
        // If the operation has been cancelled, we still need to enter the "Finished" state.
        if isCancelled {
            finish()
        }
    }
    
    override final func main() {
        
        if !self.isCancelled {
            self.isExecuting = true
            
            execute()
        } else {
            finish()
        }
    }
    
    func execute() {
        print("\(type(of: self)) must override `execute()`.")
    }
    
    final func finish() {
        if !self.isFinished && isExecuting {
            self.isFinished = true
        }
    }
    
    override func cancel() {
        super.cancel()
    }
}
