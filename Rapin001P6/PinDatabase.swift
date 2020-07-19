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
    
    func clockPunch(pin: String) -> Int {
        // check if there is a previous punch for this user by poping the timecards[] and checking if the last entry has a clock out time
        
        //iff it does have a clock out time, create a new timeCardEntry without a clout time (== nil)
        
        //if it does not, set the 
    }
}
