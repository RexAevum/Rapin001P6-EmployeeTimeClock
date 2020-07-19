//
//  TimeCardCell.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/17/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class TimeCardCell: UITableViewCell {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var clockOutTimeField: UITextField!
    @IBOutlet weak var clockInTimeField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstNameField.text = ""
        lastNameField.text = ""
        clockInTimeField.text = ""
        clockOutTimeField.text = ""
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
