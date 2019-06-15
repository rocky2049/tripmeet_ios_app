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
    var activities: [Activity]
    var uuid = UUID.init()
    
    init(name: String = "", activities: [Activity] = []){
        self.id = uuid.uuidString
        self.name = name
        self.activities = activities
    }
}


