//
//  SDIdentity.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 1/11/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

public class SDIdentity: NSObject {
    
    public var ldapkey:String!
    public var netid:String!
    public var duid:String!
    public var lastName:String!
    public var givenName:String!
    public var displayName:String!
    public var affiliation:String?
    public var emails:[String]?
    public var postOfficeBox:[String]?
    
    public convenience init(infoDict:[String:Any]){
        self.init()
        self.ldapkey = infoDict["ldapkey"] as! String
        self.netid = infoDict["netid"] as! String
        self.duid = infoDict["duid"] as! String
        self.lastName = infoDict["sn"] as! String
        self.givenName = infoDict["givenName"] as! String
        self.affiliation = infoDict["primary_affiliation"] as? String
        self.emails = infoDict["emails"] as? [String]
        self.postOfficeBox = infoDict["post_office_box"] as? [String]
    }

}
