//
//  SDPlace.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import CoreLocation

class SDPlace: NSObject {
    var id:String!
    var name:String!
    var locationName:String!
    var position:CLLocation!
    var googleMapLink:URL?
    var tags:[String]?
    var phoneNumber:String?
    var open:Bool?
    
    init(id:String, name:String, locationName:String, longitude:Double, latitude:Double, googleMapLink:String?, tags:[String]?, phoneNumber:String?, open:Bool?) {
        self.id = id
        self.name = name
        self.locationName = locationName
        self.position = CLLocation(latitude: latitude, longitude: longitude)
        self.googleMapLink = googleMapLink != nil ? URL(string: googleMapLink!) : nil
        self.tags = tags
        self.phoneNumber = phoneNumber
        self.open = open
    }
    
}
