//
//  ISSViewController+TableView.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation

import UIKit

extension ISSViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issPass?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ISSViewConstants.issTableViewCell, for: indexPath) as? ISSTableViewCell {
            cell.configure(issPass![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
