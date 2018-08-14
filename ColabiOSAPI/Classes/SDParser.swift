//
//  SDParser.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

public class SDParser: NSObject {
    
   
    
    public class func textInString(filterTerm:String, text:NSString) -> Bool{
        let range = text.range(of: filterTerm, options: NSString.CompareOptions.caseInsensitive)
        return (range.location != NSNotFound)
    }
    
    class func filter(filterObject:[[String:Any]], filterTerm:String, filterKeys:[String]) -> [[String:Any]]
    {
        let filtered = filterObject.filter({ (object) -> Bool in
            var toInclude:Bool = false
            
            filterKeys.forEach({ (key) in
                if let term = object[key] as? NSString, toInclude == false
                {
                    toInclude = SDParser.textInString(filterTerm: filterTerm, text: term)
                }
            })
            
            return toInclude
        })
        return filtered
    }
    
}
