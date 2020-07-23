//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import UIKit
import CoreData

class PinPad: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    //MARK: Pin Field Link
    
    @IBOutlet var digit_1: UILabel!
    
    @IBOutlet var digit_2: UILabel!
    
    @IBOutlet var digit_3: UILabel!
    
    @IBOutlet var digit_4: UILabel!
    
    //MARK: Pin Buttons Collection Link
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: Other Variables
    var enteredPin: String = ""
    fileprivate let PLACE_HOLDER = "-"
    fileprivate let PIN_LENGHT = 4
    
    var timer = Timer()

    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        //add timer for reprinting the the clock timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
  
        
       _ =  timeLabel.adjustsFontSizeToFitWidth
        timeLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearAllPinDigits()
        submitButton.titleLabel?.text = ""
    }
    
    @objc func tick(){
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "logInSegue"?:
            
            // MARK: FIXME

            //use segue.destination to set the variables on the other side
            break
        default:
            preconditionFailure("unknown segue")
        }
    }
 
    
    //MARK: Custom Functions
    
    @IBAction func press(_ sender: UIButton) {
        let buttonValue = sender.tag
        setDigits(givenDigit: buttonValue)
        
        
    }
    // cleare button that will be replaced with action later on once the DB is in place
    @IBAction func clear(_ sender: UIButton) {
        clearAllPinDigits()
    }
    
    //log the button action
    @IBAction func log(_ sender: UIButton) {
        
        
        if let punch = PinDatabase.sharedInstance.clockPunch(pin: enteredPin, time: Date()){
            PinDatabase.sharedInstance.lastPin = enteredPin
            if punch == "nopin"{
                // add alert for when code is wrong
                let title = "Incorrect PIN"
                let message = "The code you have entered is not a valid employee number."
                let alertControl = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "OK", style: .cancel, handler: {(action) -> Void in
                    self.clearAllPinDigits()
                })
                alertControl.addAction(alertOk)
                present(alertControl, animated: true, completion: nil)
                
            }
            else if punch == "admin"{
                performSegue(withIdentifier: "logInSegue", sender: nil)
            }
            else{
                print(punch)
            }
        }
        else{
            clearAllPinDigits()
            print("Error")
        }
    }
    
    /*
     set's the appropriate digit
 */
   @discardableResult func setDigits(givenDigit: Int) -> Bool? {
      //  pinFailed.alpha = 0
        if (digit_1.text == PLACE_HOLDER){
            digit_1.text = String(givenDigit)
            
            if (enteredPin.count <= PIN_LENGHT){
                enteredPin += String(givenDigit)
            }
            return true
        }
        else if (digit_2.text == PLACE_HOLDER){
            digit_2.text = String(givenDigit)
            
            if (enteredPin.count < PIN_LENGHT){
                enteredPin += String(givenDigit)
            }
            return true
        }
        else if (digit_3.text == PLACE_HOLDER){
            digit_3.text = String(givenDigit)
            if (enteredPin.count < PIN_LENGHT){
                enteredPin += String(givenDigit)
            }
            return true
        }
        else if (digit_4.text == PLACE_HOLDER){
            digit_4.text = String(givenDigit)
            if (enteredPin.count < PIN_LENGHT){
                enteredPin += String(givenDigit)
                
                if(enteredPin == PinDatabase.sharedInstance.ADMIN){
                    submitButton.setTitle("ADMIN", for: .normal)
                    
                    return true
                }
                else{
                    let isClocked = isClockedIn(pin: enteredPin)
                    if isClocked == true {
                        submitButton.setTitle("PUNCH OUT", for: .normal)
                    }
                    else {
                        submitButton.setTitle("PUNCH IN", for: .normal)
                    }
                    
                }
            }
            //MARK: chenge view in bar controller
            return true
        }
        // all digits have been set, ignore the input
        return false
    }
    
    //MARK:- custom func
    fileprivate func clearAllPinDigits() {
       //sleep(5)
        //print(enteredPin)
        digit_1.text = PLACE_HOLDER
        digit_2.text = PLACE_HOLDER
        digit_3.text = PLACE_HOLDER
        digit_4.text = PLACE_HOLDER
        enteredPin = ""
        submitButton.titleLabel?.text = ""
    }
    
    fileprivate func isClockedIn(pin: String) -> Bool?{
        // check what the last time card entry is
        let user = PinDatabase.sharedInstance.pairDatabase[pin]
        // if user doesn't exist, set to punch in
        if user == nil {return nil}
        
        //get last punch
        let lastPunch = user?.timeCards.last
        
        //if its full (has clock out time) or doesnt exist -> return false
        if (lastPunch == nil || lastPunch?.clockOut != nil){
            return false
        }
        //if exist time entry without clock out time -> return false
        else if (lastPunch?.clockOut == nil){
            return true
        }
        
        // return nil for no info
        return nil
    }
    

}
