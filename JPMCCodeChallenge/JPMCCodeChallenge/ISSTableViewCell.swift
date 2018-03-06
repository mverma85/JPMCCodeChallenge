//
//  ISSTableViewCell.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation
import UIKit

class ISSTableViewCell: UITableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var riseTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // to configure cell with given ISS pass
    func configure(_ issPass: ISSPass) {
        durationLabel.text = "\(durationString): \(issPass.duration ?? 0) \(secondsString)"
        if let risetime = issPass.risetime {
            let date = Date(timeIntervalSince1970: Double(risetime))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            riseTimeLabel.text = "\(riseTimeString): \(dateFormatter.string(from: date))"
        }
    }
}
