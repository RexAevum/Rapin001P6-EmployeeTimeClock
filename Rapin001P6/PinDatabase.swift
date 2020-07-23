//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import Foundation
import UIKit
import CoreData

class PinDatabase: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        // aCoder.encode
        aCoder.encode(pinIndex, forKey: "pinIndex")
        aCoder.encode(pairDatabase, forKey: "pairDatabase")
        aCoder.encode(timeCardDB, forKey: "timeCardDB")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        //
        pinIndex = aDecoder.decodeObject(forKey: "pinIndex") as! [String]
        pairDatabase = aDecoder.decodeObject(forKey: "pairDatabase") as! [String : Employee]
        timeCardDB = aDecoder.decodeObject(forKey: "timeCardDB") as! [TimeCardEntry]
        lastPin = String()
        super.init()
    }
    
    override init() {
        pinIndex = []
        pairDatabase = [:]
        timeCardDB = []
        lastPin = String()
    }
    

 
    

    
    // create only one instance
    let coder = NSCoder()
    static let sharedInstance = PinDatabase()
    
    // database
    let ADMIN = "0000"
    
    var lastPin: String
    var pinIndex: [String]!
    var pairDatabase: [String : Employee]!
    var timeCardDB: [TimeCardEntry]
    
    // filepaths for new archives
    let indexURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var dirNext = dir.first
        return (dirNext?.appendingPathComponent("employees.archive"))!
    }()
    let pairsURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var dirNext = dir.first
        return (dirNext?.appendingPathComponent("pairs.archive"))!
    }()
    let timeCardsURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var dirNext = dir.first
        return (dirNext?.appendingPathComponent("timeCards.archive"))!
    }()

    
    
    //add function to add new employee  to the DB
    @discardableResult func addEmployee(employee: Employee) -> Int {
        // add to dictionry
        let pin = employee.pin
        pairDatabase[pin!] = employee
        
        //add pin to collection for table view
        pinIndex.append(pin!)
        let newIndex = pinIndex.index(of: pin!)!
        return newIndex
    }
    
    //add function to delete item
    func deletePair(index: Int) -> () {
        let pin = pinIndex[index]
        
        pairDatabase.removeValue(forKey: pin)
        
        pinIndex.remove(at: index)
    }
    
    //add function to move item
    func movePair(indexFrom: Int, indexTo: Int) -> () {
        let temp = pinIndex[indexFrom]
        pinIndex.remove(at: indexFrom)
        pinIndex.insert(temp, at: indexTo)
    }
    
    fileprivate func createNewTimeCardEntry(_ pin: String, _ time: Date, _ user: Employee?) -> String? {
        //if this is first entry - create new entry
        let punch = TimeCardEntry(pin: pin, inTime: time, outTime: nil, clockedIn: nil)
        user?.timeCards.append(punch)
        timeCardDB.append(punch)
        return String(describing: timeCardDB.index(of: punch))
    }
    
    @discardableResult func clockPunch(pin: String, time: Date) -> String? {
        //check if pin is admin pin
        if (pin == ADMIN) {return "admin"}
        // if user number is wrong, return error
        let user = pairDatabase[pin]
        if (user == nil) {return "nopin"}
        
        // check if there is a previous punch for this user by poping the timecards[] and checking if the last entry has a clock out time
        let lastPunch = user?.timeCards.last
        if lastPunch == nil{
            return createNewTimeCardEntry(pin, time, user)
        }
        else if (lastPunch?.clockOut == nil){
            //if it does not, set the clock out time to the passed time - time
            user?.timeCards.removeLast()
            // remove from main db and add updated entry to db and employee
            let index = timeCardDB.index(of: lastPunch!)
            timeCardDB.remove(at: index!)
            
            //add new
            let newPunch = TimeCardEntry(pin: pin, inTime: (lastPunch?.clockIn)!, outTime: time, clockedIn: false)
            user?.timeCards.append(newPunch)
            timeCardDB.append(newPunch)
            return String(describing: timeCardDB.index(of: newPunch))
        }
        else{
            //iff it does have a clock out time, create a new timeCardEntry without a clock time (== nil)
            return createNewTimeCardEntry(pin, time, user)
        }
        
        
        //update timecard if it exists in timeCardDB and update it in the user collection of timecard
        
        //return the index of the timecardentry in the DB
        return "Error: End of options of punch"
    }

    @discardableResult func saveToDB() -> Bool {
        let s1 = NSKeyedArchiver.archiveRootObject(pinIndex, toFile: indexURL.path)
        let s2 = NSKeyedArchiver.archiveRootObject(pairDatabase, toFile: pairsURL.path)
        let s3 = NSKeyedArchiver.archiveRootObject(timeCardDB, toFile: timeCardsURL.path)
        
        return s1  && s3
        
    }
    
    @discardableResult func loadFromDB() -> Bool {
        if let l1 = NSKeyedUnarchiver.unarchiveObject(withFile: indexURL.path) as? [String]{
            pinIndex = l1
        }
        if let l2 = NSKeyedUnarchiver.unarchiveObject(withFile: pairsURL.path) as? [String : Employee]{
            pairDatabase = l2
        }
        if let l3 = NSKeyedUnarchiver.unarchiveObject(withFile: timeCardsURL.path) as? [TimeCardEntry]{
            timeCardDB = l3
        }
        
        return true
    }
    
}
