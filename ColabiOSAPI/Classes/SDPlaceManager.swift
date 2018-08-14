//
//  SDPlacemanager.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class SDPlaceManager: NSObject {
    
    static let shared = SDPlaceManager()
    
    public func getPlaceCategories(accessToken:String, error: @escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/categories?access_token=\(accessToken)", headers: nil, body: nil, error: {(message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [[String:Any]] else {
                error("Data for place categories incorrectly formatted")
                return
            }
            completion(json)
        })
    }
    
    public func placeForTag(tag:String, accessToken:String, error: @escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/items?tag=\(tag)&access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [[String:Any]] else {
                error("Data for tag: \(tag) incorrectly formatted")
                return
//                json.forEach({ (dict) in
//                    let place = SDPlace(id: dict["place_id"], name: dict["name"], locationName: dict["location"], longitude: <#T##Double#>, latitude: <#T##Double#>, googleMapLink: <#T##String?#>, tags: <#T##[String]?#>, phoneNumber: <#T##String?#>, open: <#T##Bool?#>)
//                })
            }
            completion(json)
        })
    }
    
    public func placeForID(id:String, accessToken:String, error: @escaping (String) -> Void, completion:@escaping ([String:Any]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "places/items/index?place_id=\(id)&access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [String:Any] else {
                error("Data for placeID: \(id) incorrectly formatted")
                return
            }
            completion(json)
        })
    }

}
