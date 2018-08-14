//
//  SDCourse.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

public protocol PropertyNames {
    func propertyNames() -> [String]
}

public protocol PropertyReflectable{}

public extension PropertyNames
{
    public func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
}

public extension PropertyReflectable{
    public subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        for child in m.children {
            if child.label == key { return child.value }
        }
        return nil
    }
}

public class SDCourse: NSObject, PropertyNames, PropertyReflectable {
    
    var id:String!
    var offerNumber:String!
    var subject:String!
    var catalogNumber:String!
    var courseDescription:String! = ""
    var title:String!
    var units:String!
    var grading:String!
    var consent:String!
    var semester:String!
    var school:String!
    //var attributes:[String]! = [String]()
    var termsOffered = [String]()
    var career:String!
    var requirements:String! = ""
    
    public convenience init(infoDict:[String:Any]) {
        self.init()
        self.id = infoDict["crse_id"] as! String
        self.offerNumber = infoDict["crse_offer_nbr"] as! String
        self.subject = infoDict["subject"] as! String
        self.catalogNumber = infoDict["catalog_nbr"] as! String
        if let description = infoDict["descrlong"] as? String{
            self.courseDescription = description
        }
        self.title = infoDict["course_title_long"] as! String
        self.units = infoDict["units_maximum"] as! String
        self.grading = infoDict["grading_basis"] as! String
        self.consent = infoDict["consent_lov_descr"] as! String
        self.semester = ((infoDict["ssr_crse_typoff_cd"] as? String) != nil) ? (infoDict["ssr_crse_typoff_cd"] as? String) : ""
        self.school = infoDict["acad_group_lov_descr"] as? String
        self.career = infoDict["acad_career"] as! String
        if let reqs = infoDict["rqrmnt_group_descr"] as? String{
            self.requirements = reqs
        }
        if let terms = infoDict["terms_offered"] as? [String:Any]{
            if let term = terms["term_offered"] as? [[String:Any]]{
                let termOffered = term.map({ (json) -> String in
                    return json["strm_lov_descr"] as! String
                })
                self.termsOffered = termOffered
            }
        }
        
        //if let attributes = infoDict["course_attributes"] as? [String;Any]
        
        
    }

}


