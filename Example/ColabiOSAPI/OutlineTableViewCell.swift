//
//  OutlineTableViewCell.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/10/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

protocol OutlineTableViewDelegate: UITableViewDataSource, UITableViewDelegate{
    
}

class OutlineTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    //var delegate: OutlineTableViewDelegate!
    
    
    private var _children = [String]()
    var children:[String]{
        set{
            self._children = newValue
        }
        get{
            return self._children
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //self.tableView.delegate = self.delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

