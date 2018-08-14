//
//  SDRequester.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/9/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit
import os.log

class SDRequester: NSObject {
    var baseURL:String!
    
    static let colab = SDRequester(baseURL: SDConstants.URL.colab)
    
    static let streamer = SDRequester(baseURL: SDConstants.URL.streamer)

    init(baseURL:String) {
        super.init()
        self.baseURL = baseURL
    }
    
    func makeHTTPRequest(method:String, endpoint: String, boundary: String, body: Data, error:@escaping (String) -> Void, completion:@escaping (_ result:Any) -> Void) {
        #if DEBUG
            os_log("%@: Make Request: %@, %@", self.description, method, self.baseURL + endpoint)
        #endif
        
        let request = NSMutableURLRequest(url: NSURL(string: self.baseURL + endpoint)! as URL)
        request.httpMethod = method
        request.httpBody = body
        
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        executeHTTPRequest(request: request as URLRequest, completion: completion, errorHandler: { result in
            if let errorDescription = result["error"] as? String {
                error(errorDescription)
            }
        })
    }
    
    func makeHTTPRequest(method:String, endpoint: String, headers:[String: String]?,body: [String: Any]?, error:@escaping (String) -> Void, completion:@escaping (_ result:Any) -> Void) {
        #if DEBUG
            os_log("%@: Make Request: %@, %@", self.description, method, self.baseURL + endpoint)
        #endif
        
        if let url = URL(string: self.baseURL + endpoint)
        {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = method
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if (headers != nil)
            {
                for (key, value) in headers! {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            if (body != nil)
            {
                request.httpBody = try! JSONSerialization.data(withJSONObject: body as Any, options: [])
            }
            
            executeHTTPRequest(request: request as URLRequest, completion: completion, errorHandler: { result in
                if let errorDescription = result["error"] as? String {
                    error(errorDescription)
                }
            })
        }
        else
        {
            os_log("%@: URL %@ is null", self.description, self.baseURL + endpoint)
        }
        
    }
    
    private func executeHTTPRequest(request: URLRequest, completion:@escaping (_ result:Any) -> Void, errorHandler:@escaping (_ result:[String:Any]) -> Void =  { error in
        if let errorDescription = error["error"] as? String
        {
            os_log("Error making http request: %@", errorDescription)
        }
        }) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if (data != nil)
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    completion(json)
                }
                catch
                {
                    os_log("%@: Error serializing json: %@, Trying as string.", self.description, error.localizedDescription)
                    if let dataString = String(data:data!, encoding:.utf8)
                    {
                        errorHandler(["error":dataString])
                    }
                    else
                    {
                        os_log("%@: Could not format data as string", self.description)
                    }
                }
                //completion(data!)
            }
            else if (error != nil)
            {
                errorHandler(["error":error.debugDescription])
                #if DEBUG
                    os_log("%@: Error: %@", self.description, error.debugDescription)
                #endif
            }
        })
        task.resume()
    }
}
