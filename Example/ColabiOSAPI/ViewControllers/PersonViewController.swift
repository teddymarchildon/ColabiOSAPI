//
//  PersonViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/11/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import ColabiOSAPI

class PersonViewController: UIViewController {

    var identity: SDIdentity!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var netidLabel: UILabel!
    
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postOfficeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = "\(identity.givenName!) \(identity.lastName!)"
        self.netidLabel.text = identity.netid
        self.affiliationLabel.text = identity.affiliation
        self.emailLabel.text = identity.emails?.first
        identity.postOfficeBox?.forEach({ (mail) in
            self.postOfficeLabel.text?.append("\(mail) ")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
