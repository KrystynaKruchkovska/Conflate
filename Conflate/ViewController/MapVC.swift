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
    var gesturePinAnnotation:DroppablePinAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.longPressRecogniser()
        self.mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupLocation()
        self.addAnnotations()
    }
    
    
    func longPressRecogniser(){
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapVC.dropPinAnnotation(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func dropPinAnnotation(_ gestureRecognizer : UIGestureRecognizer){
        
        if gestureRecognizer.state != .began { return }
        self.removeGestureAddedPinAnnotation()
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        self.userLocation = Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude)
        self.gesturePinAnnotation = DroppablePinAnnotation(coordinate:Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude), title: "Addeed with gesture", uniquePostID: nil)
        
        self.mapView.addAnnotation(gesturePinAnnotation)
    }
    
    func removeGestureAddedPinAnnotation(){
        if gesturePinAnnotation != nil {
            self.mapView.removeAnnotation(gesturePinAnnotation)
        }
    }
    
    func addAnnotations() {
        self.postViewModel.readPosts { (posts) in
            
            let annotations = posts.map({ DroppablePinAnnotation(coordinate:  $0.location, title: $0.title, uniquePostID: $0.uuid) })
            
            DispatchQueue.main.async {
                self.addAnnotation(annotations)
            }
        }
    }
    
    func addAnnotation(_ annotations:[DroppablePinAnnotation]) {
        for annotation in annotations {
            self.mapView.addAnnotation(annotation)
        }
    }

    
    func getPostFor(uniquePostID:String,handler:@escaping (_ post: Post?) -> ()){
        
        self.postViewModel.readPosts { (allPosts) in
            for post in allPosts {
                if post.uuid == uniquePostID {
                    handler(post)
                    return
                }
            }
            handler(nil)
            
        }
    }
    
    func presentPostInfoVCForPost(post:Post) {
        let presentInfo = PostInfoVC()
        presentInfo.post = post
        presentInfo.modalPresentationStyle = .fullScreen
        present(presentInfo, animated: true, completion: nil)
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
            self.locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            self.showAlertWithError(clErr)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddPostVC {
            let vc = segue.destination as? AddPostVC
            
            if vc?.postViewModel !== self.postViewModel {
                vc?.postViewModel = self.postViewModel
            }
            
            vc?.location = self.userLocation
            self.removeGestureAddedPinAnnotation()
        }
    }
}

extension MapVC:MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.ReusableIdentifier.mapPin)
        let button = UIButton(type: .infoDark) as UIButton
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.2745098039, green: 0.2196078431, blue: 0.4196078431, alpha: 1)
        pinAnnotation.rightCalloutAccessoryView = button
        pinAnnotation.canShowCallout = true
        pinAnnotation.animatesDrop = false
        return pinAnnotation
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            let annotationPin = self.getDroppablePinAnnotationForView(view)
            
            guard let uniquePostID = annotationPin?.uniquePostID else {
                self.showAlertWithMessage("Click add button to create new post", title: "You've choosen location", handler: nil)
                
                return
            }
            
            self.getPostFor(uniquePostID: uniquePostID) { (post) in
                
                guard let post = post else {
                    self.showAlertWithMessage("Post may have been deleted.", title: Constants.Alerts.errorAlertTitle, handler: nil)
                    return
                }
                
                self.presentPostInfoVCForPost(post: post)
            }
        }
    }
    
    func getDroppablePinAnnotationForView(_ view:MKAnnotationView) -> DroppablePinAnnotation? {
        guard let annotation = view.annotation as? DroppablePinAnnotation else {
            return nil
        }
        
        return annotation
    }
    
    
}
