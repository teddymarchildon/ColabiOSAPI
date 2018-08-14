              //
//  SDCurriculum.swift
//  SwiftyDuke
//
//  Created by Lucy Zhang on 12/31/17.
//  Copyright © 2017 Lucy Zhang. All rights reserved.
//

import UIKit

public class SDCurriculum: NSObject {
    
    public static let shared = SDCurriculum()
    //let requestor = SDRequester(baseURL: SDConstants.URL.streamer)

    public func getCoursesForSubject(subject:String, accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void) {
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/courses/subject/\(subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)?access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            
            guard let json = response as? [String:Any],
            let resp = json["ssr_get_courses_resp"] as? [String:Any],
                let searchResult = resp["course_search_result"] as? [String:Any],
                let subjects = searchResult["subjects"] as? [String:Any],
                let sub = subjects["subject"] as? [String:Any],
                let courseSummaries = sub["course_summaries"] as? [String:Any],
                let courseSummary = courseSummaries["course_summary"] as? [[String:Any]]
                else {
                    error("Course data incorrectly formatted for subject: \(subject) requested")
                return
            }
            completion(courseSummary)
        })
    }
    
    public func offeringDetailsForCourse(id:String, offerNumber:String, accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([String:Any]) -> Void) {
        
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/courses/crse_id/\(id)/crse_offer_nbr/\(offerNumber)?access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
                error(message)
        }, completion: { (response) in
            
            guard let json = response as? [String:Any],
                let resp = json["ssr_get_course_offering_resp"] as? [String:Any],
                let result = resp["course_offering_result"] as? [String:Any],
                let offering = result["course_offering"] as? [String:Any] else {
                    error("Offering details for id: \(id) incorrectly formatted")
                    return
            }
            completion(offering)
        })
    }
    
    public func curriculumValues(field:String, accessToken:String, error:@escaping (String) -> Void, completion:@escaping ([[String:Any]]) -> Void){
        SDRequester.streamer.makeHTTPRequest(method: "GET", endpoint: "curriculum/list_of_values/fieldname/\(field)?access_token=\(accessToken)", headers: nil, body: nil, error: { (message) in
            error(message)
        }, completion: { (response) in
            
            guard let json = response as? [String:Any],
                let resp = json["scc_lov_resp"] as? [String:Any],
                let lovs = resp["lovs"] as? [String:Any],
                let lov = lovs["lov"] as? [String:Any],
                let values = lov["values"] as? [String:Any],
                let value = values["value"] as? [[String:Any]] else {
                    error("Curriculum values for field: \(field) incorrectly formatted")
                    return
            }
            completion(value)
        })
    }
}
