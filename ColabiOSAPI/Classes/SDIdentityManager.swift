//
//  SDIdentity.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log
public class SDIdentityManager: NSObject {
    
    public static let shared = SDIdentityManager()
    
    public func personForNetID(netID:String,accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([String:Any]) -> Void){
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "ldap/people/netid/\(netID)?access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [[String:Any]] else {
                error("Data for netID: \(netID) incorrectly formatted")
                return
            }
            completion(json[0])
        })
        
    }
    
    public func personForUniqueID(uniqueID:String,accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([String:Any]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "ldap/people/duid/\(uniqueID)?access_token=\(accessToken)", headers: nil, body: nil, error: {(message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [String:Any] else {
                error("Data for uniqueID: \(uniqueID) incorrectly formatted")
                return
            }
            completion(json)
        })
    }
    
    public func searchPeopleDirectory(queryTerm:String, accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint:  "ldap/people?q=\(queryTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            guard let json = response as? [[String:Any]] else {
                error("Data for query term: \(queryTerm) incorrectly formatted")
                return
            }
            completion(json)
        })
    }

}
