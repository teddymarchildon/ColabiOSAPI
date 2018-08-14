//
//  LongTextTableViewCell.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/11/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

class LongTextTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
