//
//  FirebaseHandler.swift
//  DistanceTravelled
//
//  Created by Sameera Chandimal on 6/25/18.
//  Copyright © 2018 Leonardo Savio Dabus. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseHandler {
    static func addTrip(username: String, distance: String, amount: String) {
        let ref: DatabaseReference = Database.database().reference()
        let key = ref.child("trips").childByAutoId().key
        
        ref.child("trips").child(key).setValue([
            "username": username,
            "distance": distance,
            "amount": amount
        ])
    }
}
