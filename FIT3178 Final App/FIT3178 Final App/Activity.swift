//
//  Activity.swift
//  FIT3178 Final App
//
//  Created by Laoqi He on 13/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit

class Activity: NSObject {
    var id: String
    var name: String
    var desc: String
    var location: String
    var time: Date
    
    init(id: String = "", name: String = "", desc: String = "", location: String = "", time: Date = Date()){
        self.id = id
        self.name = name
        self.desc = desc
        self.location = location
        self.time = time
    }

}
