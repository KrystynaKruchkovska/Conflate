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
    var postArray:[Post] = []
    var arrayLocations:[DroppablePin] = []
    var gesturePin:DroppablePin!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longPressRecogniser()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.readPostAddAnnotation()
   
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    
    func longPressRecogniser(){
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapVC.dropPin(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func dropPin(_ gestureRecognizer : UIGestureRecognizer){
        
        if gestureRecognizer.state != .began { return }
        removeGestureAddedPin()
        //removeSpinner()
       // addSpinner()
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        self.location = Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude)
        gesturePin = DroppablePin(coordinate:Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude), title: "Addeed with gesture")
        
        mapView.addAnnotation(gesturePin)
        
    }
    
    func removeGestureAddedPin(){
        if gesturePin != nil {
            mapView.removeAnnotation(gesturePin)
        }
    }
    
    
    func readPostAddAnnotation() {
        self.postViewModel.readPosts { (posts) in
            self.postArray = posts
            self.arrayLocations = self.postArray.map({ DroppablePin(coordinate:  $0.location, title: $0.title) })
            DispatchQueue.main.async {
                self.addAnnotation()
            }
            
        }
    }
    
    func addAnnotation(){
        for location in self.arrayLocations{
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = location.coordinate
            self.mapView.addAnnotation(annotation)
        }
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
        //fatalError("Implement this function")
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
extension MapVC:MKMapViewDelegate{
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.2745098039, green: 0.2196078431, blue: 0.4196078431, alpha: 1)
        pinAnnotation.canShowCallout = true
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
}
