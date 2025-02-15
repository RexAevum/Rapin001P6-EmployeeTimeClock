//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #6
//  DUE: Thursday 07/26/2020 //

import Foundation

class Employee: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(pin, forKey: "pin")
        aCoder.encode(timeCards, forKey: "timeCards")
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        pin = aDecoder.decodeObject(forKey: "pin") as! String
        timeCards = aDecoder.decodeObject(forKey: "timeCards") as! [TimeCardEntry]
    }
    
    
    var firstName: String!
    var lastName: String!
    var pin: String!
    var timeCards: [TimeCardEntry]
    
    
    init(first: String!, last: String!, pin: String!) {
        self.firstName = first
        self.lastName = last
        self.pin = pin
        self.timeCards = []
        
    }
    convenience override init() {
        self.init(first: "Add First Name", last: "Add Last Name", pin: "Add 4 Digit PIN Number")
    }
    
    
    
}
