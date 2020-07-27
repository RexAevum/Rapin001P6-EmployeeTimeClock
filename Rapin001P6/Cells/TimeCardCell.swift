//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #6
//  DUE: Thursday 07/26/2020 //

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
