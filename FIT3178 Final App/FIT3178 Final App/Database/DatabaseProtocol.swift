//
//  DatabaseProtocol.swift
//  FIT3178 Final App
//
//  Created by Laoqi He  on 14/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    case plan
    case activities
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onPlanChange(change: DatabaseChange, planActivities: [Activity])
    func onActivityListChange(change: DatabaseChange, activities: [Activity])
}

protocol DatabaseProtocol: AnyObject {
    var defaultPlan: Itinerary {get}
    
    func addActivity(name: String, desc: String, location: String, time: Date) -> Activity
    func addPlan(planName: String) -> Itinerary
    func addActivityToPlan(activity: Activity, plan: Itinerary) -> Bool
    func deleteActivity(activity: Activity)
    func deletePlan(plan: Itinerary)
    func removeActivityFromPlan(activity: Activity, plan: Itinerary)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}

