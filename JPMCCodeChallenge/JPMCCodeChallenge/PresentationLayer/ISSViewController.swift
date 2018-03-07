//
//  ISSViewController.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import UIKit
import CoreLocation

class ISSViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var issPass: [ISSPass]?

    struct ISSViewConstants {
        static let issTableViewCell = "issTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAndRequestPermission()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     this will display error alert
     - parameter error: error string to be displayed
     */
    func showError(_ error: String) {
        let alertController = UIAlertController(title: errorString, message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okString, style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
