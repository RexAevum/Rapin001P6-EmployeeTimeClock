//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import UIKit

class DetailEditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var pinField: UITextField!
    @IBOutlet var urlField: UITextField!
    
    // variables
    let maxPinLength = 4
    var oldPin: String = String()
    var pin: String = String()
    var url: URL = URL(string: "http://www.apple.com")!
    
    override func viewDidLoad() {
        pinField.keyboardType = .namePhonePad
        urlField.keyboardType = .URL
        
        pinField.clearButtonMode = .whileEditing
        urlField.clearButtonMode = .whileEditing
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        oldPin = pin
        pinField.text = pin
        urlField.text = url.absoluteString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // get all the needed data
        let pin = pinField.text
        let url = URL(string: urlField.text!)
        let oldPinIndex = PinDatabase.sharedInstance.pinIndex.index(of: oldPin)
        
        //update DB
            
        PinDatabase.sharedInstance.pinIndex[oldPinIndex!] = pin!
        PinDatabase.sharedInstance.pairDatabase.removeValue(forKey: self.oldPin)
        // will create new if key does not exist
        PinDatabase.sharedInstance.pairDatabase.updateValue(url!, forKey: pin!)
    }

    
    //MARK: - Text Field Delegate
    // what to do when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    // will limit how many characters can go into pin field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // setting the max lenght to maxPinSize
        if (pinField.isFirstResponder){
            let currentText: NSString = textField.text! as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            
            return newText.count <= maxPinLength
        }
        else{
            return true
        }
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

