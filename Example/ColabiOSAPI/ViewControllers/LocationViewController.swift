//
//  LocationViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/12/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class LocationViewController: CategoryPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFields(){
        
    }
    
    func loadResponse(){
        
    }

}

extension LocationViewController: CategoryPickerDelegate{
    
}
