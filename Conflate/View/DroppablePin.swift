//
//  Pin.swift
//  Conflate
//
//  Created by Mac on 1/9/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    public dynamic var coordinate: CLLocationCoordinate2D
    var title:String?
    
    init(coordinate: Location, title:String) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.long)
    }

}