//
//  ISSPass.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

struct ISSPassResponse: Decodable {
    var message: String?
    var response: [ISSPass]?
}

struct ISSPass: Decodable {
    var duration: Int?
    var risetime: Int?
}
