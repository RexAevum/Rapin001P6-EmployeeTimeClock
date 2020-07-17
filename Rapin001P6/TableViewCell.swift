//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    

    
    @IBOutlet var pinField: UITextField!
    @IBOutlet var urlField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pinField.text = ""
        urlField.text = ""

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 

}
