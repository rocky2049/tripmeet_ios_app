//
//  addItineraryDelegate.swift
//  FIT3178 Final App
//
//  Created by Laoqi He on 15/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//
protocol AddItineraryDelegate: AnyObject {
    func addItinerary(newItinerary: Itinerary) -> Bool
}
