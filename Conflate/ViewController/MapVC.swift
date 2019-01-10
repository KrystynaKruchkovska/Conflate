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
    var userLocation: Location!
    var gesturePin:DroppablePin!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longPressRecogniser()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        self.addAnnotations()
    }
    
    
    func longPressRecogniser(){
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapVC.dropPin(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func dropPin(_ gestureRecognizer : UIGestureRecognizer){
        
        if gestureRecognizer.state != .began { return }
        removeGestureAddedPin()
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        self.userLocation = Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude)
        gesturePin = DroppablePin(coordinate:Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude), title: "Addeed with gesture")
        
        mapView.addAnnotation(gesturePin)
    }
    
    func removeGestureAddedPin(){
        if gesturePin != nil {
            mapView.removeAnnotation(gesturePin)
        }
    }
    
    func addAnnotations() {
        self.postViewModel.readPosts { (posts) in
            
            let annotations = posts.map({ DroppablePin(coordinate:  $0.location, title: $0.title) })
            
            DispatchQueue.main.async {
                self.addAnnotation(annotations)
            }
        }
    }
    
    func addAnnotation(_ annotations:[DroppablePin]) {
        for annotation in annotations {
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func getLocation() {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            if let currentLocation = locationManager.location {
                self.userLocation = Location(lat:currentLocation.coordinate.latitude, long:currentLocation.coordinate.longitude)
            }
        }
    }
    
    func zoomMap(lat:Double, lon:Double) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
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
        if isLocationNotAuthorized() {
            showAlertWithMessage(Constants.Strings.location_Is_not_authorized, title: Constants.Alerts.errorAlertTitle, handler: nil)
        } else {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        fatalError("Implement this function")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddPostVC {
            let vc = segue.destination as? AddPostVC
            
            if vc?.postViewModel !== self.postViewModel {
                vc?.postViewModel = self.postViewModel
            }
            
            vc?.location = self.userLocation
            removeGestureAddedPin()
        }
    }
}

extension MapVC:MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.ReusableIdentifier.mapPin)
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.2745098039, green: 0.2196078431, blue: 0.4196078431, alpha: 1)
        pinAnnotation.canShowCallout = true
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
}
