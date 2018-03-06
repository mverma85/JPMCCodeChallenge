//
//  GetISSPassOperationTests.swift
//  JPMCCodeChallengeTests
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import XCTest
@testable import JPMCCodeChallenge

class GetISSPassOperationTests: XCTestCase {
    var lat = "28.461910"
    var lon = "77.053182"

    func testOperationInit() {
        let operation = GetISSPassOperation(lat: lat, lon: lon, handler: {_ in})
        XCTAssertNotNil(operation)
    }
}

