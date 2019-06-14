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
    
    init(id: String = "", name: String = "", activities: [Activity] = []){
        self.id = id
        self.name = name
        self.activities = activities
    }
}


