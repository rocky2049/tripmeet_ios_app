//
//  FirebaseController.swift
//  FIT3178 Final App
//
//  Created by Laoqi He  on 14/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class FirebaseController: NSObject, DatabaseProtocol{    
    let DEFAULT_ITINERARY_NAME = "Default Plan"
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var activitiesRef: CollectionReference?
    var planRef: CollectionReference?
    
    var activityList: [Activity]
    var defaultPlan: Itinerary
    
    override init() {
        // To use Firebase in our application we first must run the FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        activityList = [Activity]()
        defaultPlan = Itinerary()
        
        super.init()
        
        authController.signInAnonymously() { (authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed")
            }
            
            self.setUpListeners()
        }
    }
    
    func setUpListeners() {
        activitiesRef = database.collection("activities")
        activitiesRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseActivitiesSnapshot(snapshot: querySnapshot!)
        }
        
        planRef = database.collection("plans")
        planRef?.whereField("name", isEqualTo: DEFAULT_ITINERARY_NAME).addSnapshotListener { querySnapshot,
            error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teams: \(error!)")
                return
            }
            self.parsePlanSnapshot(snapshot: documents.first!)
        }
    }
    func parseActivitiesSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach { change in
            let documentRef = change.document.documentID
            let name = change.document.data()["name"] as! String
            let desc = change.document.data()["desc"] as! String
            let location = change.document.data()["location"] as! String
            let time = change.document.data()["time"] as! Date
            print(documentRef)
            
            if change.type == .added {
                print("New Activity: \(change.document.data())")
                let newActivity = Activity()
                newActivity.name = name
                newActivity.desc = desc
                newActivity.location = location
                newActivity.time = time
                newActivity.id = documentRef
                
                activityList.append(newActivity)
            }
            if change.type == .modified {
                print("Updated Activity: \(change.document.data())")
                let index = getActivityIndexByID(reference: documentRef)!
                activityList[index].name = name
                activityList[index].desc = desc
                activityList[index].location = location
                activityList[index].time = time
                activityList[index].id = documentRef
            }
            if change.type == .removed {
                print("Removed Activity: \(change.document.data())")
                if let index = getActivityIndexByID(reference: documentRef) {
                    activityList.remove(at: index)
                }
            }
        }
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.activities || listener.listenerType == ListenerType.all {
                listener.onActivityListChange(change: .update, activities: activityList)
            }
        }
    }
    
    func parsePlanSnapshot(snapshot: QueryDocumentSnapshot) {
        defaultPlan = Itinerary()
        defaultPlan.name = (snapshot.data()["name"] as! String)
        defaultPlan.id = snapshot.documentID
        if let activityReferences = snapshot.data()["activities"] as? [DocumentReference] {
            // If the document has an "activities" field, add activities.
            for reference in activityReferences {
                let activity = getActivityByID(reference: reference.documentID)
                guard activity != nil else {
                    continue
                }
                defaultPlan.activities.append(activity!)
            }
        }
    }
    
    func getActivityIndexByID(reference: String) -> Int? {
        for activity in activityList {
            if(activity.id == reference) {
                return activityList.firstIndex(of: activity)
            }
        }
        
        return nil
    }
    
    
    func getActivityByID(reference: String) -> Activity? {
        for activity in activityList {
            if(activity.id == reference) {
                return activity
            }
        }
        
        return nil
    }
    
    func addActivity(name: String, desc: String, location: String, time: Date) -> Activity {
        let activity = Activity()
        let id = activitiesRef?.addDocument(data: ["name" : name, "desc" : desc, "location" : location, "time" : time])
        activity.name = name
        activity.desc = desc
        activity.location = location
        activity.time = time
        activity.id = id!.documentID
        
        return activity
    }
    
    func addPlan(planName: String) -> Itinerary {
        let plan = Itinerary()
        let id = planRef?.addDocument(data: ["name" : planName, "activities": []])
        plan.id = id!.documentID
        plan.name = planName
        
        return plan
    }
    
    func addActivityToPlan(activity: Activity, plan: Itinerary) -> Bool {
        guard let activity = getActivityByID(reference: activity.id), plan.activities.count < 24 else{
            return false
        }
        
        plan.activities.append(activity)
        
        let newActivityRef = activitiesRef!.document(activity.id)
        planRef?.document(plan.id).updateData(["activities" : FieldValue.arrayUnion([newActivityRef])])
        return true
    }
    
    func deleteActivity(activity: Activity) {
        activitiesRef?.document(activity.id).delete()
    }
    
    func deletePlan(plan: Itinerary) {
        planRef?.document(plan.id).delete()
    }
    
    func removeActivityFromPlan(activity: Activity, plan: Itinerary) {
        let index = plan.activities.index(of: activity)
        let removedActivity = plan.activities.remove(at: index!)
        let removedRef = activitiesRef?.document(removedActivity.id)
        
        planRef?.document(plan.id).updateData(["activities": FieldValue.arrayRemove([removedRef!])])
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.plan || listener.listenerType == ListenerType.all {
            listener.onPlanChange(change: .update, planActivities: defaultPlan.activities)
        }
        
        if listener.listenerType == ListenerType.activities || listener.listenerType == ListenerType.all {
            listener.onActivityListChange(change: .update, activities: activityList)
        }
    }
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
}
