//
//  MapVC.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController,CLLocationManagerDelegate {
    
    var postViewModel:PostViewModel!
    var locationManager = CLLocationManager()
    var location: Location!
    
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController.searchBar
        
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    func getLocation() {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            if let currentLocation = locationManager.location {
                self.location = Location(lat:currentLocation.coordinate.latitude, long:currentLocation.coordinate.longitude)
            }
            
        }
    }
    
    func zoomMap(lat:Double, lon:Double) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.mapView.setRegion(region, animated: true)
    }
   
    func setupLocation() {
        if self.isLocationNotAuthorized() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        self.mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func isLocationNotAuthorized() -> Bool {
        return CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.getLocation()
        
        self.zoomMap(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if isLocationNotAuthorized() == true {
            showAlert(Constants.Strings.location_Is_not_authorized, title: Constants.Alerts.errorAlertTitle, handler: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddPostVC {
            let vc = segue.destination as? AddPostVC
            
            if vc?.postViewModel !== self.postViewModel {
                vc?.postViewModel = self.postViewModel
            }
            
            vc?.location = self.location    
        }
    }
    
}
