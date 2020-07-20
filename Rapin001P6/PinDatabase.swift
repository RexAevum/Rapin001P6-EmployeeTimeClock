//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import Foundation
import UIKit
import CoreData

class PinDatabase{
    // create only one instance
    static let sharedInstance = PinDatabase()
    
    // database
    let ADMIN = "0000"
    
    var lastPin: String
    var pinIndex: [String]!
    var pairDatabase: [String : Employee]!
    var timeCardDB: [TimeCardEntry]
    
    
    private init() {
        lastPin = String()
        pairDatabase = [:]
        pinIndex = []
        timeCardDB = []
        
        let employee0 = Employee(first: "First Name", last: "Last Name", pin: "PIN")
        addEmployee(employee: employee0)
        
        let employee1 = Employee(first: "Scott", last: "Malcom", pin: "0001")
        addEmployee(employee: employee1)
        
        let employee2 = Employee(first: "Jim", last: "Jackson", pin: "0002")
        addEmployee(employee: employee2)
        
        timeCardDB.append(TimeCardEntry(pin: "0001", inTime: Date(), outTime: nil))
        timeCardDB.append(TimeCardEntry(pin: "0001", inTime: Date(), outTime: Date()))
    }
    
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
        let punch = TimeCardEntry(pin: pin, inTime: time, outTime: nil)
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
            let newPunch = TimeCardEntry(pin: pin, inTime: (lastPunch?.clockIn)!, outTime: time)
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
}
