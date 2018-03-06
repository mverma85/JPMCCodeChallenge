//
//  ISSViewController+LocationManager.swift
//  JPMCCodeChallenge
//
//  Created by MANOJ on 06/03/18.
//  Copyright © 2018 MANOJ. All rights reserved.
//

import Foundation
import CoreLocation

extension ISSViewController: CLLocationManagerDelegate {

    // to check and get location permission
    func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.showError(locationServicesDisabled)
            case .authorizedAlways, .authorizedWhenInUse:
                fetchLocationManager()
            }
        } else {
            self.showError(locationServicesDisabled)
        }
    }
    
    // to start location manager
    func fetchLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    // delegate callback if location updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location?.coordinate {
            getData(lat: "\(locValue.latitude)", lon: "\(locValue.longitude)")
        }
    }
    
    // delegate callback if location manager permission changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                fetchLocationManager()
            default:
                break
            }
        } else {
            self.showError(locationServicesDisabled)
        }
    }
}
