//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #6
//  DUE: Thursday 07/26/2020 //

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    

    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var pinField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstNameField.text = ""
        lastNameField.text = ""
        pinField.text = ""
        firstNameField.placeholder = "Enter First Name"
        lastNameField.placeholder = "Enter Last Name"
        pinField.placeholder = "Enter employee PIN number"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 

}
