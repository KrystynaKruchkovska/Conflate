//
//  ConflateTabBarController.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ConflateTabBarController: UITabBarController, CLLocationManagerDelegate {

    var postViewModel:PostViewModel!
    
    private var allPostVC:AllPostsVC?
    private var mapVC:MapVC?
    
    private var locationManager = CLLocationManager()
    private var userLocation: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLocation()
        
        self.mapVC = self.getTabVC()
        self.mapVC?.postViewModel = self.postViewModel
        
        self.allPostVC = self.getTabVC()
        self.allPostVC?.postViewModel = postViewModel
    }
    
    private func getTabVC<T:UIViewController>() -> T? {
        
        for controller in self.viewControllers! {
            if let vc = controller as? T {
                return vc
            }
        }
        
        return nil
    }
    
    private func setupLocation() {
        if self.isLocationNotAuthorized() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
    }
    
    private func isLocationNotAuthorized() -> Bool {
        return CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    private func getLocation() {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            if let currentLocation = locationManager.location {
                self.userLocation = Location(lat:currentLocation.coordinate.latitude, long:currentLocation.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.getLocation()
        
        if let location = self.userLocation {
            self.mapVC?.updateUserLocation(location)
            self.allPostVC?.updateUserLocation(location)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if isLocationNotAuthorized() {
            showAlertWithMessage(Constants.Strings.location_Is_not_authorized, title: Constants.Alerts.errorAlertTitle, handler: nil)
        } else {
            self.locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            self.showAlertWithError(clErr)
        }
    }
    
}
