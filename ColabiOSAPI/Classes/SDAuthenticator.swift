//
//  SDAuthenticator.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/21/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

public class SDAuthenticator: NSObject {
    
    let requester = SDRequester(baseURL: SDConstants.URL.oauth)
    
    public static let shared = SDAuthenticator()
    
    public func authenticate(clientID:String, redirectURI:String, scope:String, completion:@escaping ([String:Any]) -> Void){
        let endpoint = "authorize.php?response_type=code&client_id=\(clientID)&scope=\(scope)&redirect_uri=\(redirectURI)"
        
        requester.makeHTTPRequest(method: "GET", endpoint: endpoint, headers: nil, body: nil, error: { (message) in
            if #available(iOS 10.0, *) {
                os_log("%@: Error: %@", self.description, message)
            } else {
                print("%@: Error: %@", self.description, message)
            }
        }, completion: { (response) in
            if #available(iOS 10.0, *) {
                os_log("%@: Response: %@", self.description, response as! [String:Any])
            } else {
                print("%@: Response: %@", self.description, response as! [String:Any])
            }
            completion(response as! [String:Any])
        })
    }

}
