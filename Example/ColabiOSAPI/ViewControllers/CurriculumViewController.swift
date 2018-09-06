//
//  CurriculumViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import ColabiOSAPI
import os.log

class CurriculumViewController: CategoryPickerViewController {

//    @IBOutlet weak var subjectField: UITextField!
//    @IBOutlet var fieldDropDown: UIPickerView!
//    @IBOutlet weak var tableView: UITableView!
    
    var selectedCourseTitle:String! = ""
    var selectedCourseID:String! = ""
    var selectedCourseOfferNumber:String! = ""
    //var subjectFields = [String]()
    //var filteredSubjectFields = [String]()
    
    //var searchActive:Bool! = false
    
    var courses = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        loadCurriculumFields()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        //self.subjectField.resignFirstResponder()
    }
    
    
    
    func loadCurriculum(){
        SDCurriculum.shared.getCoursesForSubject(subject: self.selectedField, accessToken: AccessToken.value, error: self.handleDataError) { (classes) in
            self.courses = classes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadCurriculumFields(){
        SDCurriculum.shared.curriculumValues(field: SDConstants.CurriculumField.subject, accessToken: AccessToken.value, error: {
            (message) in
            self.handleDataError(message: message)
        }, completion: { (fields) in
            self.subjectFields = fields.map({ (json) -> String in
                return "\(json["code"] as! String) - \(json["desc"] as! String)"
            })
            DispatchQueue.main.async {
                self.fieldDropDown.reloadAllComponents()
            }
        })
    }

    
    private func handleDataError(message: String) {
        os_log("%@: Response: %@", self.description, message)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? CourseViewController{

            vc.courseTitle = self.selectedCourseTitle
            vc.courseID = self.selectedCourseID
            vc.courseOfferNumber = self.selectedCourseOfferNumber
        }
    }
    

}

extension CurriculumViewController: UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCellID", for: indexPath) as! CourseTableViewCell
        
        let course = self.courses[indexPath.row]
        var title:String = ""
        if let titleLong = course["course_title_long"] as? String{
            title = titleLong
        }
        let courseNumber = course["catalog_nbr"] as! String
        
        cell.label.text = "\(courseNumber): \(title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = self.courses[indexPath.row]
        self.selectedCourseTitle = course["course_title_long"] as? String
        self.selectedCourseID = course["crse_id"] as! String
        self.selectedCourseOfferNumber = course["crse_offer_nbr"] as! String
        
        performSegue(withIdentifier: "courseSegue", sender: self)

    }
}

extension CurriculumViewController: CategoryPickerDelegate{
    func loadFields() {
        let alertController = self.presentLoadingIndicator()
        SDCurriculum.shared.curriculumValues(field: SDConstants.CurriculumField.subject, accessToken: AccessToken.value, error: {
            (message) in
            
            DispatchQueue.main.async {
                alertController.removeLoadingIndicator()
                alertController.title = "Error"
                alertController.message = message
                alertController.addDismissalButton()
            }
            self.handleDataError(message: message)
        }, completion: { (fields) in
            
            // Dismiss the loading indicator
            self.dismiss(animated: false, completion: nil)
            
            self.subjectFields = fields.map({ (json) -> String in
                return "\(json["code"] as! String) - \(json["desc"] as! String)"
            })
            DispatchQueue.main.async {
                self.fieldDropDown.reloadAllComponents()
            }
        })
    }
    
    func loadResponse() {
        let alertController = self.presentLoadingIndicator()
        SDCurriculum.shared.getCoursesForSubject(subject: self.selectedField, accessToken: AccessToken.value, error: {
            (message) in
            DispatchQueue.main.async {
                alertController.removeLoadingIndicator()
                alertController.title = "Error"
                alertController.message = message
                alertController.addDismissalButton()
            }
            self.handleDataError(message: message)
        }, completion: { (classes) in
            // Dismiss the loading indicator
            self.dismiss(animated: false, completion: nil)
            
            self.courses = classes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}


