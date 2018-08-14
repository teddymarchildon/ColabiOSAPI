//
//  CategoryPickerViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/12/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import ColabiOSAPI

protocol CategoryPickerDelegate{
    
    func loadFields()
    
    func loadResponse()
}

class CategoryPickerViewController: UIViewController {
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet var fieldDropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive:Bool! = false
    
    var subjectFields = [String]()
    var filteredSubjectFields = [String]()
    
    var selectedField:String! = ""
    
    private var _delegate:CategoryPickerDelegate!
    var delegate: CategoryPickerDelegate {
        get{
            return self._delegate
        }
        set{
            self._delegate = newValue
            self._delegate.loadFields()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        return tmpFields.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        
        guard tmpFields.count >= row else {
            return nil
        }
        let string = NSAttributedString(string: tmpFields[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        return string
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
//
//        guard tmpFields.count >= row else {
//            return nil
//        }
//        return tmpFields[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tmpFields = searchActive ? self.filteredSubjectFields : self.subjectFields
        self.selectedField = tmpFields[row]
        self.subjectField.text = self.selectedField
        delegate.loadResponse()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchActive = false
    }
    
    
    @IBAction func subjectFieldChanged(_ sender: UITextField) {
        let filterTerm = sender.text
        
        guard filterTerm != nil && (filterTerm!.count > 0) else {
            searchActive = false
            self.fieldDropDown.reloadAllComponents()
            return
        }
        
        self.filteredSubjectFields = self.subjectFields.filter({ (field) -> Bool in
            
            let include = SDParser.textInString(filterTerm: filterTerm!, text: field as NSString)
            
            return include
            
        })
        
        self.fieldDropDown.reloadAllComponents()
    }
    
    
}

