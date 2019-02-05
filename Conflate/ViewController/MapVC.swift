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

class MapVC: UIViewController {
    
    var postViewModel:PostViewModel!
    var userLocation: Location?
    private var gesturePinAnnotation:DroppablePinAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLongPressRecogniser()
        self.setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        zoomMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addAnnotations()
    }
    
    func updateUserLocation(_ location:Location) {
        self.userLocation = location
        
        if self.mapView != nil {
             self.zoomMap()
        }
    }
    
    private func setupMapView() {
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
    }
    
    private func setUpLongPressRecogniser(){
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
    
    private func removeGestureAddedPinAnnotation(){
        if gesturePinAnnotation != nil {
            self.mapView.removeAnnotation(gesturePinAnnotation)
        }
    }
    
    private func addAnnotations() {
        self.postViewModel.readPosts { [weak self] (posts) in
            
            let annotations = posts.map({ DroppablePinAnnotation(coordinate:  $0.location, title: $0.title, uniquePostID: $0.uuid) })
            
            DispatchQueue.main.async {
                self?.addAnnotation(annotations)
            }
        }
    }
    
    private func addAnnotation(_ annotations:[DroppablePinAnnotation]) {
        for annotation in annotations {
            self.mapView.addAnnotation(annotation)
        }
    }
    
    
    private func getPostFor(uniquePostID:String,handler:@escaping (_ post: Post?) -> ()){
        self.postViewModel.readPosts {(allPosts) in
            for post in allPosts {
                if post.uuid == uniquePostID {
                    handler(post)
                    return
                }
            }
            handler(nil)
        }
    }
    
    private func presentPostInfoVCForPost(post:Post) {
        let presentInfo = PostInfoVC()
        presentInfo.post = post
        presentInfo.modalPresentationStyle = .fullScreen
        present(presentInfo, animated: true, completion: nil)
    }
    
    private func zoomMap() {
        guard let location = self.userLocation else {
            return
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
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
        
        if control != view.rightCalloutAccessoryView {
            return
        }
        
        let annotationPin = self.getDroppablePinAnnotationForView(view)
        
        guard let uniquePostID = annotationPin?.uniquePostID else {
            self.showAlertWithMessage("Click add button to create new post", title: "You've choosen location", handler: nil)
            return
        }
        
        presentPostInfoVCFor(uniquePostID)
    }
    
   private func presentPostInfoVCFor(_ uniquePostID:String){
        self.getPostFor(uniquePostID: uniquePostID) { (post) in
            
            guard let post = post else {
                self.showAlertWithMessage("Post may have been deleted.", title: Constants.Alerts.errorAlertTitle, handler: nil)
                return
            }
            
            self.presentPostInfoVCForPost(post: post)
        }
    }
    
    private func getDroppablePinAnnotationForView(_ view:MKAnnotationView) -> DroppablePinAnnotation? {
        guard let annotation = view.annotation as? DroppablePinAnnotation else {
            return nil
        }
        
        return annotation
    }
    
    
}
