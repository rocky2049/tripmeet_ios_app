//
//  Itinerary.swift
//  FIT3178 Final App
//
//  Created by Laoqi He  on 14/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit

class Itinerary: NSObject {
    var id: String
    var name: String
    var startDate: Date
    var endDate: Date
    var activities: [Activity]
    var uuid = UUID.init()
    
    init(name: String, startDate:Date, endDate: Date, activities: [Activity] = []){
        self.id = uuid.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.activities = activities
    }
}


