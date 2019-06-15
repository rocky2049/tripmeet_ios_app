//
//  Location.swift
//  FIT3178 Final App
//
//  Created by Laoqi He  on 15/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit
import MapKit
class Location: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(newTitle: String, newSubtitle: String, lat: Double, long: Double){
        self.title = newTitle
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }

}
