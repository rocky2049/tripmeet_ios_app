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
    
    init(id: String, name: String, desc: String, time: Date){
        self.id = ""
        self.name = ""
        self.desc = ""
        self.location = ""
        self.time = Date()
    }

}
