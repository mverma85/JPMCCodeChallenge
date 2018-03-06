//
//  ISSViewController+Data.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

extension ISSViewController {
    
    // method to fetch ISS Pass for a perticular location
    func getData(lat: String, lon: String) {
        BusinessLayerManager.sharedManager.getISSPass(lat, lon: lon, handler: { (inner) in
            do {
                let issPass = try inner()
                self.issPass = issPass
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                self.showError(error.localizedDescription)
            }
        })
    }
    
}
