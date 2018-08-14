//
//  IdentityViewController.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import ColabiOSAPI
import os.log

class IdentityViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var _searchActive:Bool = false
    var searchActive:Bool! {
        get {
            return self._searchActive
        }
        
        set {
            self._searchActive = newValue
            self.tableView.reloadData()
        }
    }
    
    var searchResults = [[String:Any]]()
    var filtered = [[String:Any]]()
    var selectedIdentity:[String:Any]!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.searchBar.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc =  segue.destination as? PersonViewController{
            vc.identity = SDIdentity(infoDict: selectedIdentity)
        }
    }
    
    func loadIdentities(query:String){
        let alertController = self.presentLoadingIndicator()
        SDIdentityManager.shared.searchPeopleDirectory(queryTerm: query, accessToken: SDConstants.Values.testToken, error: { (message) in
            
            DispatchQueue.main.async {
                alertController.removeLoadingIndicator()
                alertController.title = "Error"
                alertController.message = message
                alertController.addDismissalButton()
            }
            
            self.handleDataError(message: message)
        }, completion: { (identities) in
            
            self.searchResults = identities
            self.filtered = identities
    
            DispatchQueue.main.async {
                alertController.dismissSelf(action: UIAlertAction())
                self.searchBar.isHidden = false
                self.tableView.reloadData()
            }
        })
    }
    
    
    private func handleDataError(message: String) {
        os_log("%@ Response: %@", message, self.description)
    }
    
}

extension IdentityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmpFiltered = (searchActive) ? filtered : searchResults
        return tmpFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identityCellID") as! CourseTableViewCell
        
        let tmpFiltered = (searchActive) ? filtered : searchResults
        
        guard indexPath.row <= tmpFiltered.count else {
            return cell
        }
        
        cell.label.text = (tmpFiltered[indexPath.row]["display_name"]) as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tmpFiltered = (searchActive) ? filtered : searchResults
        let netid = tmpFiltered[indexPath.row]["netid"] as! String
        SDIdentityManager.shared.personForNetID(netID: netid, accessToken: SDConstants.Values.testToken, error: { (message) in
            self.handleDataError(message: message)
        }, completion:  { (personInfo) in
            self.selectedIdentity = personInfo
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "identitySegue", sender: self)
            }
        })
    }
}

extension IdentityViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filtered = self.searchResults.filter({ (identityObject) -> Bool in
            var toInclude:Bool = false
            let displayName = identityObject["display_name"] as? NSString
            let netid = identityObject["netid"] as? NSString
            var email:NSString! = ""
            if let emails = identityObject["emails"] as? [NSString]
            {
                email = emails[0]
            }
            let name = identityObject["givenName"] as? NSString
            let toSearch = [displayName, netid, email, name]
            
            for string in toSearch{
                if let str = string{
                    let range = str.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    toInclude = (range.location != NSNotFound)
                    if (toInclude){
                        break
                    }
                }
            }
            return toInclude
        })
        
        searchActive = (filtered.count > 0)
        
        //sself.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setSearchInactive()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        setSearchInactive()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setSearchInactive()
        if let text = searchBar.text{
            loadIdentities(query: text)
        }
        
    }
    
    func setSearchInactive(){
        searchActive = false;
    }
}

extension IdentityViewController: UISearchBarDelegate{
    
}

extension IdentityViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchBar.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchBar.isHidden = false
    }
}

