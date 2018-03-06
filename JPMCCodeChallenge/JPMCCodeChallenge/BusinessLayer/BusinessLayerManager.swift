//
//  BusinessLayerManager.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

class BusinessLayerManager {
    
    static var sharedManager = BusinessLayerManager()
    fileprivate(set) var queue = OperationQueue()

    // add api call to queue
    func getISSPass(_ lat: String, lon: String, handler: @escaping (_ inner: () throws -> [ISSPass]?) -> Void) {
        let getISSPassOperation = GetISSPassOperation(lat: lat, lon: lon, handler: handler)
        queue.addOperation(getISSPassOperation)
    }
    
}
