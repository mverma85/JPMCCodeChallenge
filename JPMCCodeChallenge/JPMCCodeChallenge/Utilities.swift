//
//  Utilities.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

class Utilities {
    class func stringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
